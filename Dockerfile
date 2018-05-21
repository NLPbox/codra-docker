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

# we need discoursegraphs for conversion to .rs3
WORKDIR /opt
RUN git clone https://github.com/arne-cl/discoursegraphs.git

# discoursegraphs needs to be installed in a virtualenv, because it needs a newer
# version of nltk. We need to replace 'sh' with 'bash' to make virtualenv work.
SHELL ["/bin/bash", "-c"]

WORKDIR /opt/discoursegraphs
RUN apt-get update -y && apt-get install -y python-dev python-pip git graphviz graphviz-dev \
    libxml2-dev libxslt-dev && rm -rf /var/lib/apt/lists/* && \
    pip2 install virtualenvwrapper==4.8.2 && \
    echo "export WORKON_HOME=$HOME/.virtualenvs" > ~/.profile && \
    echo "source /usr/local/bin/virtualenvwrapper.sh" > ~/.profile && \
    source ~/.profile && \
    mkvirtualenv -p python2.7 discoursegraphs

# on current Ubuntu systems you will need to install pygraphviz manually,
# cf. http://stackoverflow.com/questions/32885486/pygraphviz-importerror-undefined-symbol-agundirected
RUN source ~/.profile && workon discoursegraphs && pip2 install pygraphviz==1.3.1 \
    --install-option="--include-path=/usr/include/graphviz" \
    --install-option="--library-path=/usr/lib/graphviz/" && \
    pip2 install -r requirements.txt && deactivate


# add test file and end-to-end parsing script
ADD input*.txt codra.sh test_codra.py codra2rs3.* /opt/codra-rst-parser/

WORKDIR /opt/codra-rst-parser

# by default, the container will parse the test file and produce its
# RST tree in *.dis format
ENTRYPOINT ["./codra.sh"]
CMD ["input_long.txt"]
