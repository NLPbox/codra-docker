FROM nlpbox/charniak:2018-05-02

RUN apt-get update -y && \
    apt-get install -y git build-essential \
        openjdk-8-jre \
        python-numpy python-dev python-pip \
        science-linguistics && \
    pip install nltk==3.2.1 scikit-learn==0.18.1 scipy==0.18.1 sh==1.12.14 && \
    rm -rf /var/lib/apt/lists/*


WORKDIR /opt
# I put the repo on sourceforge because of github's file size restrictions
# and low LFS quota for free accounts.
#
# The CODRA source code relies on a number of hardcoded paths / temporary
# files, e.g. without tmp_doc.prob, Discourse_Parser.py won't run.
RUN git clone git://git.code.sf.net/p/codra-rst-parser/code codra-rst-parser && \
    rm codra-rst-parser/tmp* && touch codra-rst-parser/tmp_doc.prob


# install WordNet tools (wordnet itself is part of science-linguistics)

ENV WNHOME=/usr/share/wordnet WNSEARCHDIR=/usr/share/wordnet
WORKDIR /opt/codra-rst-parser/Tools
RUN python -c "import nltk; nltk.download('wordnet')" && \
    tar xzf WordNet-QueryData-1.49.tar.gz

WORKDIR /opt/codra-rst-parser/Tools/WordNet-QueryData-1.49
RUN perl Makefile.PL && make && make install

# add test file and end-to-end parsing script
ADD input*.txt codra.sh test_codra.py /opt/codra-rst-parser/

WORKDIR /opt/codra-rst-parser

# by default, the container will parse the test file and produce its
# RST tree in *.dis format
ENTRYPOINT ["./codra.sh"]
CMD ["input_long.txt"]
