FROM node:16

RUN npm install -s -g serverless

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
