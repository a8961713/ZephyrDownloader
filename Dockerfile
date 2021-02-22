FROM ubuntu:18.04

RUN apt update 

RUN apt -y install \
python3-pip \
python3-packaging \
git \
pv

RUN pip3 install --upgrade pip

RUN pip install west

RUN mkdir /scripts

VOLUME /artifacts

COPY  download.sh /scripts/download.sh

CMD /scripts/download.sh
