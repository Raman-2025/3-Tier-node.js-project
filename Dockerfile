FROM node:20-alpine
WORKDIR /app/client
COPY client/package*.json ./
RUN npm install
COPY client/  ./
RUN npm run build

WORKDIR /app/server
COPY server/package*.json ./
RUN  npm install --omit=dev
RUN npm install mysql2
COPY server/  ./ 

ENV NODE_ENV=production

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /app
USER appuser

EXPOSE 5000
CMD ["npm","start"]
