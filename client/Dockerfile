# pull official base image
FROM node:13.12.0-alpine

# set working directory
WORKDIR /app

# install app dependencies
COPY package.json ./
RUN npm install --silent

# add app
COPY . ./

RUN npm run build

FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=0 /app/build /usr/share/nginx/html