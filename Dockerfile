# syntax=docker/dockerfile:1
FROM node:20-alpine AS builder

WORKDIR /app
COPY package*.lock .
RUN npm install
RUN npx playwright install
COPY . .

FROM builder AS dev

COPY --from=builder /app /app

ENV HOST=0.0.0.0
WORKDIR /app

CMD ["yarn", "run", "dev"]