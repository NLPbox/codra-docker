FROM nlpbox/nlpbox-base:16.04

RUN apt-get update -y && \
    apt-get install -y build-essential flex swig \
        openjdk-8-jre \
        python-numpy python-dev python-pip \
        science-linguistics && \
    pip install nltk


# the CODRA github repo needs git-lfs because it contains large files

WORKDIR /opt
RUN wget https://github.com/github/git-lfs/releases/download/v1.5.0/git-lfs-linux-amd64-1.5.0.tar.gz && \
    tar xzf git-lfs-linux-amd64-1.5.0.tar.gz
WORKDIR /opt/git-lfs-1.5.0
RUN ./install.sh

WORKDIR /opt
RUN git lfs clone https://github.com/arne-cl/codra-rst-parser.git


# install the Charniak parser (the version distributed with CODRA does not
# compile)

WORKDIR /opt/codra-rst-parser/Tools/
RUN rm -rf CharniakParserRerank && \
    git clone https://github.com/BLLIP/bllip-parser CharniakParserRerank

WORKDIR /opt/codra-rst-parser/Tools/CharniakParserRerank
RUN make && python setup.py install


# install WordNet tools (wordnet itself is part of science-linguistics)

ENV WNHOME=/usr/share/wordnet
WORKDIR /opt/codra-rst-parser/Tools
RUN python -c "import nltk; nltk.download('wordnet')" && \
    tar xzf WordNet-QueryData-1.49.tar.gz

WORKDIR /opt/codra-rst-parser/Tools/WordNet-QueryData-1.49
RUN perl Makefile.PL


# add test file

ADD input.txt /opt/codra-rst-parser/

# Tools/CharniakParserRerank/parse.sh: 18: 
# Tools/CharniakParserRerank/parse.sh: first-stage/PARSE/parseIt: 
#     not foundsecond-stage/programs/features/best-parses: not found
