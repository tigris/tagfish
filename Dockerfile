FROM alpine:3.4
MAINTAINER Clement Labbe <clement.labbe@rea-group.com>

RUN apk add --update ruby \
    ruby-dev \
    ruby-io-console \
    diffutils \
    linux-headers \
    build-base \
    ca-certificates && \
    rm /var/cache/apk/* && \
    rm -rf /usr/share/ri

RUN echo -e 'gem: --no-rdoc --no-ri' > /etc/gemrc

COPY pkg/tagfish-latest.gem /cwd/
WORKDIR /cwd
RUN gem install tagfish-latest.gem
RUN mkdir -p /root/.docker

ENTRYPOINT ["tagfish"]
