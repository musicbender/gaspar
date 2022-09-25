FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm
RUN mkdir /app
WORKDIR /app
COPY ./Gemfile .
COPY ./Gemfile.lock .
RUN npm install -g nodemon 
RUN bundle install
COPY ./ .

EXPOSE 3000

CMD ["nodemon", "-L"]