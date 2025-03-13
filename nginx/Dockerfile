FROM alpine:3.21 AS system

RUN apk add --update --no-cache nginx

VOLUME ["/usr/share/nginx/html"]

RUN adduser -D -g 'nonroot' nonroot && chown -R nonroot:nonroot /var/lib/nginx /var/log/nginx /var/run/nginx

USER nonroot

CMD ["nginx", "-g", "daemon off;"]