FROM alpine:edge
MAINTAINER PolyQY <gzmanyang@gmail.com>

ENV LANG C.UTF-8

RUN apk add --update --no-cache ca-certificates

RUN set -ex \
        && apk add --no-cache --virtual .run-deps \
                ffmpeg \
                libmagic \
                python3 \
                python3-dev \
                py3-numpy \
                py3-pillow \
                libwebp \
                py3-yaml \
                py3-requests \
                gcc \
		openssl-dev \
		musl-dev \
		libffi-dev

RUN set -ex \
        && pip3 install --upgrade pip \
        && pip3 install ehforwarderbot \
        && pip3 install efb-telegram-master \
        && pip3 install efb-wechat-slave \
        && pip3 install efb-qq-slave \
        && pip3 install efb-fb-messenger-slave
        
CMD ["ehforwarderbot"]
