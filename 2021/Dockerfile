FROM ruby:2.7.2

RUN apt-get update && apt-get install -y \
            vim

WORKDIR /home/junze
COPY . .
RUN bundle install
