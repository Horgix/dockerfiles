FROM nginx:alpine

MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

RUN apk add --update unzip wget

RUN wget https://release.larsjung.de/h5ai/h5ai-0.29.0.zip -O /srv/h5ai.zip \
      && mkdir -p /srv/h5ai \
      && unzip /srv/h5ai.zip -d /srv/h5ai \
      && rm /srv/h5ai.zip \
      && chown -R nginx:nginx /srv/h5ai

RUN rm /etc/nginx/conf.d/default.conf

COPY site.conf /etc/nginx/conf.d/site.conf

