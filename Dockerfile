FROM registry.gitlab.com/pages/hugo/hugo_extended:0.105.0 AS builder
WORKDIR /site
COPY . /site
RUN ls -la && hugo --gc

###

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
RUN sed -i 's/#error_page/error_page/' /etc/nginx/conf.d/default.conf
COPY --from=builder /site/public /usr/share/nginx/html
