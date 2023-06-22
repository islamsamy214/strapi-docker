FROM node:16-alpine
# Installing libvips-dev for sharp Compatibility
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

WORKDIR /app
COPY package.json ./
RUN npm install --ignore-scripts=false --foreground-scripts --verbose sharp
ENV PATH /app/node_modules/.bin:$PATH

COPY . .
RUN chown -R node:node /app
USER node
RUN npm run build

EXPOSE 1337

CMD ["npm", "run", "develop"]
