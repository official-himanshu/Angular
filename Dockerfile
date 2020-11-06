#FROM node:latest as builder
#RUN mkdir -p /app
#WORKDIR /app
#COPY dist .

FROM nginx:alpine
COPY default.conf /etc/nginx/conf.d/default.conf
COPY dist/FormSubmit usr/share/nginx/html