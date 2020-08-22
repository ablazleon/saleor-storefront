FROM node:10 as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ARG API_URI
ARG SENTRY_DSN
ARG SENTRY_APM
ARG DEMO_MODE
ARG GTM_ID
ENV API_URI ${API_URI:-https://smallshop-dev-62acqvdwoq-ew.a.run.app/graphql/}
RUN API_URI=${API_URI} npm run build

FROM nginx:stable
WORKDIR /app
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist/ /app/
