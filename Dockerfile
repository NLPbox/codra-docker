FROM nlpbox/nlpbox-base:16.04

RUN apt-get update -y && \
    apt-get install -y build-essential flex openjdk-8-jre

WORKDIR /opt
RUN wget http://alt.qcri.org/tools/discourse-parser/releases/current/Discourse_Parser_Dist.tar.gz && \
    tar xfz Discourse_Parser_Dist.tar.gz

WORKDIR /opt/Discourse_Parser_Dist/Tools/
RUN rm -rf CharniakParserRerank && \
    git clone https://github.com/BLLIP/bllip-parser CharniakParserRerank
WORKDIR /opt/Discourse_Parser_Dist/Tools/CharniakParserRerank

RUN make


ADD input.txt /opt/Discourse_Parser_Dist/

WORKDIR /opt/Discourse_Parser_Dist/

RUN apt-get install -y python-numpy science-linguistics


ENV WNHOME=/usr/share/wordnet
WORKDIR /opt/Discourse_Parser_Dist/Tools
RUN tar xzf WordNet-QueryData-1.49.tar.gz

WORKDIR /opt/Discourse_Parser_Dist/Tools/WordNet-QueryData-1.49
RUN perl Makefile.PL

# Tools/CharniakParserRerank/parse.sh: 18: 
# Tools/CharniakParserRerank/parse.sh: first-stage/PARSE/parseIt: 
#     not foundsecond-stage/programs/features/best-parses: not found

WORKDIR /opt/Discourse_Parser_Dist/Tools/CharniakParserRerank
RUN apt-get install swig python-dev -y && python setup.py install

RUN apt-get install python-pip -y && pip install nltk && \
    python -c "import nltk; nltk.download('wordnet')"
