FROM ruby:2.5.1

RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev libjemalloc-dev
RUN apt-get -y autoclean

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN apt-get install nodejs -y
RUN npm -v
RUN node -v

# Set the locale
RUN mkdir /diamond-liquid
WORKDIR /diamond-liquid

# install rails and diamond-liquid Gemfile
COPY Gemfile /diamond-liquid/Gemfile
COPY Gemfile.lock /diamond-liquid/Gemfile.lock
RUN gem install bundler -v 2.0.1
RUN bundle install
