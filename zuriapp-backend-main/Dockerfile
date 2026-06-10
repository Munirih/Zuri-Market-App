FROM node:26-alpine3.22

WORKDIR /app

COPY package*.json ./
RUN npm install ci --only=production

COPY . .

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 5000

CMD ["node", "app.js"]