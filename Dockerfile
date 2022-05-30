FROM nginx:1.21.4-alpine
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf