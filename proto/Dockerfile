FROM ubuntu:latest

RUN apt-get update \
  && apt-get install -y \
    ruby \
    curl

ENV PATH="./bin:${PATH}"

RUN gem install grpc-tools

RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install -y nodejs

WORKDIR /tmp

ENTRYPOINT ["buf"]
CMD ["help"]
