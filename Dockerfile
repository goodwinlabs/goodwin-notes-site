ARG base_url=

FROM registry.gitlab.com/pages/hugo/hugo_extended:0.132.2 AS builder
ENV HUGO_BASEURL=${base_url}
WORKDIR /site
COPY . /site
RUN hugo --gc --environment production

###

FROM hugomods/hugo:nginx
COPY --from=builder /site/public /site
# FROM nginx:alpine
# COPY --from=builder /site/public /usr/share/nginx/html
