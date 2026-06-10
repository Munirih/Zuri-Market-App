FROM node:26-alpine3.22

WORKDIR /app

COPY package*.json ./
RUN npm install ci --only=production

COPY . .

EXPOSE 5000

CMD ["node", "app.js"]