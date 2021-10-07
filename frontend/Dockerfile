FROM node:16.9.1

WORKDIR /app

COPY package.json ./

RUN yarn install

COPY . .

CMD ["yarn", "start"]
