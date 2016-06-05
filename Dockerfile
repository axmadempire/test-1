# Alpine is a lightweight Linux
FROM mhart/alpine-node:5

# Update latest available packages
RUN apk update && \
    apk add git && \
    rm -rf /var/cache/apk/* /tmp/*
# openvpn bash shadow@testing

RUN npm install -g grunt-cli bower

RUN adduser -D app 
WORKDIR /home/app
ADD . .
RUN chown app:app /home/app -R

# run as user app from here on
USER app
RUN npm install && bower install && grunt build

RUN mkdir /tmp/torrent-stream && chown app:app /tmp/torrent-stream
VOLUME [ "/tmp/torrent-stream" ]
EXPOSE 6881 9000

CMD [ "npm", "start" ]
