ARG platform
FROM --platform=${platform:-linux/amd64} ruby:3.1.3

WORKDIR /app
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
COPY . .
RUN bundle install

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]

# Run cmd to start docker container: "docker build . -t virtual_host_service_api:latest"
