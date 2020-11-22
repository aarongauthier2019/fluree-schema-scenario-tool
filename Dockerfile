FROM python:3.9-buster
WORKDIR /usr/src/fsst
ADD https://fluree-releases-public.s3.amazonaws.com/fluree-stable.zip /usr/src/
COPY fsst_tests.sh /usr/src/fsst/fsst_tests.sh
COPY fsst /usr/src/fsst/fsst
RUN apt-get update && \ 
    apt-get upgrade --yes && \
    apt-get --yes install apt-utils && \
    apt-get --yes install curl && \
    apt-get install --yes gcc && \
    apt-get --yes install libpython-dev && \
    apt-get --yes install openjdk-11-jdk && \
    apt-get install libmariadb-dev && \
    python3 -m pip install pip --force && \
    python3 -m pip install mysql && \
    python3 -m pip install base58 && \
    python3 -m pip install bitcoinlib && \
    python3 -m pip install aioflureedb && \
    apt-get remove gcc libpython-dev -y  && \
    cd  /usr/src && \    
    unzip fluree-stable.zip && \
    rm fluree-stable.zip && \
    mv fluree-*/* fsst/ && \
    rmdir fluree-* && \
    apt autoremove --yes && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["python3"]
