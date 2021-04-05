# This file is a template, and might need editing before it works on your project.
FROM node

WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV

COPY package.json /usr/src/app/
RUN yarn

COPY . /usr/src/app

EXPOSE 333
CMD [ "yarn", "start" ]
