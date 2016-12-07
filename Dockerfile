FROM nlpbox/nlpbox-base:16.04

RUN apt-get update -y && \
    apt-get install -y build-essential flex swig \
        openjdk-8-jre \
        python-numpy python-dev python-pip \
        science-linguistics && \
    pip install nltk scikit-learn scipy


# install the Charniak parser separately (the version distributed with CODRA
# does not compile)

WORKDIR /opt
RUN git clone https://github.com/BLLIP/bllip-parser

#WORKDIR /opt/codra-rst-parser/Tools/
#RUN rm -rf CharniakParserRerank && \
#    git clone https://github.com/BLLIP/bllip-parser CharniakParserRerank
#WORKDIR /opt/codra-rst-parser/Tools/CharniakParserRerank

WORKDIR /opt/bllip-parser
RUN make && python setup.py install



WORKDIR /opt
# I put the repo on sourceforge because of github's file size restrictions
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
ADD input.txt codra.sh /opt/codra-rst-parser/

# by default, the container will parse the test file and produce its
# RST tree in *.dis format
ENTRYPOINT ["./codra.sh"]
CMD ["input.txt"]
