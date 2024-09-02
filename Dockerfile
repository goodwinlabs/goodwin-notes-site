ARG BASE_URL

FROM registry.gitlab.com/pages/hugo/hugo_extended:0.132.2 AS builder
ENV HUGO_BASEURL=${BASE_URL}
WORKDIR /site
COPY . /site
RUN hugo --gc --environment production

###

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/* && \
    sed -i 's/#error_page/error_page/' /etc/nginx/conf.d/default.conf
COPY --from=builder /site/public /usr/share/nginx/html
