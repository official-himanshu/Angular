FROM node:latest as builder

RUN mkdir -p /app

WORKDIR /app

COPY . .

RUN npm install
RUN npm install @angular/cli
RUN npm run build --prod

CMD ["npm", "start"]

FROM nginx:alpine
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder app/dist/FormSubmit usr/share/nginx/html