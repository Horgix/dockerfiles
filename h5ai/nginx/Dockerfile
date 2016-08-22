FROM nginx:alpine

MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

ADD https://release.larsjung.de/h5ai/h5ai-0.29.0.zip /srv/h5ai.zip
RUN apk add --update unzip
RUN mkdir -p /srv/h5ai \
      && unzip /srv/h5ai.zip -d /srv/h5ai \
      && rm /srv/h5ai.zip \
      && chown -R nginx:nginx /srv/h5ai

COPY site.conf /etc/nginx/conf.d/site.conf
RUN rm /etc/nginx/conf.d/default.conf
