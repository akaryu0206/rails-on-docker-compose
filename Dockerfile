FROM ruby:2.6.5-alpine3.11
# RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
# RUN apk --update add gcc make libc-dev libxml2-dev libxslt-dev
RUN apk add --no-cache build-base bash
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]
