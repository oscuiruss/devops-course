FROM alpine:3.21

RUN apk add --no-cache nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

VOLUME ["/usr/share/nginx/html"]

RUN adduser -D -g 'nonroot' nonroot && chown -R nonroot:nonroot /var/lib/nginx /var/log/nginx /var/run/nginx

USER nonroot

CMD ["nginx", "-g", "daemon off;"]