FROM nginx:alpine

COPY conf/nginx.conf /etc/nginx/nginx.conf

VOLUME ["/usr/share/nginx/html"]

CMD ["nginx", "-g", "daemon off;"]