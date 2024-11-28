FROM --platform=linux/amd64 ubuntu

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

### Image updates & utility

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" TZ="Europe/Paris" apt-get install -y \
    tzdata \
    git-all \
    libpq-dev \
    postgresql-client \
    curl \
    # rbenv
    build-essential \
    checkinstall \
    zlib1g-dev

### Ruby Version Manager (Rbenv)

ENV RBENV_ROOT /usr/local/src/rbenv
ENV PATH ${RBENV_ROOT}/bin:${RBENV_ROOT}/shims:$PATH
RUN git clone https://github.com/rbenv/rbenv.git ${RBENV_ROOT} \
  && git clone https://github.com/rbenv/ruby-build.git \
    ${RBENV_ROOT}/plugins/ruby-build \
  && ${RBENV_ROOT}/plugins/ruby-build/install.sh \
  && echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN rbenv --version
RUN rbenv install 3.1.2

# Setup rails project

WORKDIR /app
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN rbenv local 3.1.2
RUN gem install bundler
COPY . .
RUN bundle install

CMD bundle exec rails s -b 0.0.0.0

# Run cmd to start docker container: "docker build -f Dockerfile ."