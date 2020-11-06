FROM nginx:alpine
COPY default.conf /etc/nginx/conf.d/default.conf
COPY FormSubmit usr/share/nginx/html