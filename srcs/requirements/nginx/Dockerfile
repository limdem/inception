FROM alpine:3.16

RUN apk update && \
	apk upgrade && \
	apk add nginx && \
	apk add openssl && \
	apk add shadow 

RUN mkdir -p /run/nginx && \
	rm /etc/nginx/http.d/default.conf && \
	chown -R nginx:nginx /var/www/localhost/htdocs && chmod -R 755 /var/www/localhost/htdocs && \
	chown -R nginx:nginx /var/log/nginx && \
	openssl req -x509 -nodes -days 365 \
	-subj "/C=FR/ST=PRS/O=42School/OU=student/CN=dgauvin" \
	-newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt && \
	chown -R nginx:nginx /etc/ssl/private/nginx-selfsigned.key && \
	chown -R nginx:nginx /etc/ssl/certs/nginx-selfsigned.crt

COPY conf/inception.conf /etc/nginx/http.d

COPY conf/nginx.conf /etc/nginx

EXPOSE 443

USER nginx

CMD ["nginx", "-g", "daemon off;"]
