FROM node:16-alpine as builder

WORKDIR /code

ADD package.json yarn.lock /code
RUN yarn
ADD . /code

# 选择更小体积的基础镜像
FROM nginx:alpine
COPY --from=builder code/build /usr/share/nginx/html
