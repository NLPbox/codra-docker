FROM nlpbox/nlpbox-base:16.04

RUN apt-get update -y && \
    apt-get install -y build-essential flex swig \
        openjdk-8-jre \
        python-numpy python-dev python-pip \
        science-linguistics && \
    pip install nltk==3.2.1 scikit-learn==0.18.1 scipy==0.18.1

# The Charniak parser version distributed with CODRA does not compile,
# but we can't simply replace it, because it was modified by the CODRA authors
# (at least parse.sh). For the sake of modifying CODRA as little as possible,
# we will build a newer version of the parser in a different directory,
# but keep using all the (modified?) Charniak parser resources provided
# in the CODRA source tree.

WORKDIR /opt
RUN git clone https://github.com/BLLIP/bllip-parser
WORKDIR /opt/bllip-parser

# To make the Charniak parser build process fully reproducible, we will
# build a specific commit (i.e. the most recent commit
# available on 2016-12-08).
RUN git checkout -b codra-docker 1b223fc0cdd391aac6ba6630978e4a0d8b491031
RUN make && python setup.py install



WORKDIR /opt
# I put the repo on sourceforge because of github's file size restrictions
# and low LFS quota for free accounts.
RUN git clone git://git.code.sf.net/p/codra-rst-parser/code codra-rst-parser


# install WordNet tools (wordnet itself is part of science-linguistics)

ENV WNHOME=/usr/share/wordnet WNSEARCHDIR=/usr/share/wordnet
WORKDIR /opt/codra-rst-parser/Tools
RUN python -c "import nltk; nltk.download('wordnet')" && \
    tar xzf WordNet-QueryData-1.49.tar.gz

WORKDIR /opt/codra-rst-parser/Tools/WordNet-QueryData-1.49
RUN perl Makefile.PL && make && make install


WORKDIR /opt/codra-rst-parser
# The CODRA source code relies on a number of hardcoded paths / temporary
# files, e.g. without tmp_doc.prob, Discourse_Parser.py won't run.
RUN rm tmp* && touch tmp_doc.prob

# add test file and end-to-end parsing script
ADD input*.txt codra.sh /opt/codra-rst-parser/

# by default, the container will parse the test file and produce its
# RST tree in *.dis format
ENTRYPOINT ["./codra.sh"]
CMD ["input_long.txt"]
