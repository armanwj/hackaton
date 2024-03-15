FROM node:14 as build
WORKDIR /app
COPY package*.json /app/
RUN npm install
RUN npm install -g @angular/cli@10.2.4
COPY . /app
ARG configuration=production
RUN npm run build -- --outputPath=./dist/out 


FROM nginx
COPY --from=build /app/dist/out/ /usr/share/nginx/html
COPY /nginx/nginx-custom.conf /etc/nginx/conf.d/default.conf
