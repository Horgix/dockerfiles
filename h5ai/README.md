# h5ai-docker

Dockerfiles for running h5ai

- h5ai-fpm : https://hub.docker.com/r/horgix/h5ai-fpm/
- h5ai-nginx : https://hub.docker.com/r/horgix/h5ai-nginx/

```
  myh5aifpm:
    image:          horgix/h5ai-fpm
    volumes:
      - /srv/h5ai-conf:/srv/h5ai/_h5ai/private/conf
      - /srv/h5ai-files:/srv/h5ai/files
      - /srv/h5ai/_h5ai/public/cache
  myh5ainginx:
    image:          horgix/h5ai-nginx
    links:
      - myh5aifpm:php
    ports:
      - "80:80"
    volumes_from:
     - myh5aifpm
```
