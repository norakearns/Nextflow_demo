FROM debian:latest

MAINTAINER norakearns

RUN apt-get update && apt-get install -y curl 
RUN apt-get install -y cowsay

ENV PATH=$PATH:/usr/games/

RUN curl -sSL https://github.com/COMBINE-lab/salmon/releases/download/v1.5.2/salmon-1.5.2_linux_x86_64.tar.gz | tar xz \
&& mv /salmon-*/bin/* /usr/bin/ \
&& mv /salmon-*/lib/* /usr/lib/