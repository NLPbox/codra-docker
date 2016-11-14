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

#root@5822a8cd5a47:/opt/Discourse_Parser_Dist/Tools/CharniakParserRerank# python setup.py install
#Generating CharniakParser SWIG wrapper files
#Searching for latest installed version of swig...
#Using 'swig'
#Running 'swig -python -c++ -module CharniakParser -Ifirst-stage/PARSE/ -Wall -builtin -outdir python/bllipparser -o first-stage/PARSE/swig/wrapper.C first-stage/PARSE/swig/wrapper.i'
#Error while running command: Command 'swig' not found.
#Build failed!


#root@5822a8cd5a47:/opt/Discourse_Parser_Dist# python Discourse_Parser.py input.txt 
#Traceback (most recent call last):
#  File "Discourse_Parser.py", line 5, in <module>
#    import TopicFeatures
#  File "/opt/Discourse_Parser_Dist/TopicFeatures.py", line 4, in <module>
#    import nltk
#ImportError: No module named nltk


