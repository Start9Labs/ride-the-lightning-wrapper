FROM node:10-alpine

RUN apk update
RUN apk add --no-cache tini

WORKDIR /RTL

COPY ./RTL/package.json /RTL/package.json
COPY ./RTL/package-lock.json /RTL/package-lock.json

# Install dependencies
RUN npm install --only=prod

COPY ./RTL /RTL

ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod +x /usr/local/bin/docker_entrypoint.sh
ADD ./configurator/target/armv7-unknown-linux-musleabihf/release/configurator /usr/local/bin/configurator
RUN chmod +x /usr/local/bin/configurator

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
