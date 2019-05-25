FROM python:3.7-alpine as builder

ENV LANG C.UTF-8

WORKDIR /wheels
RUN set -ex \
        && apk add --no-cache --virtual .run-deps \
            ffmpeg \
            libmagic \
            libjpeg-turbo-dev \
            py3-pillow \
            py3-numpy \
            libwebp \
            py3-yaml \
            py3-requests \
	        openssl-dev \
		    musl-dev \
            zlib-dev \
		    libffi-dev \
        && apk add --no-cache --virtual .build-deps \
            build-base \
        && pip install -U pip \
        && pip wheel ehforwarderbot \
        && pip wheel imageio-ffmpeg \
        && pip wheel efb-telegram-master \
        && pip wheel efb-qq-slave \
        && apk del --purge .build-deps

FROM python:3.7-alpine
MAINTAINER PolyQY <gzmanyang@gmail.com>

ENV LANG C.UTF-8

RUN apk add --no-cache \
        ffmpeg \
        libmagic \
        libwebp 
COPY --from=builder /wheels /wheels
RUN pip install -U pip \
    && pip install ehforwarderbot -f /wheels \
    && pip install imageio-ffmpeg -f /wheels \
    && pip install efb-telegram-master -f /wheels \
    && pip install efb-qq-slave -f /wheels \
    && rm -rf /wheels \
    && rm -rf /root/.cache/pip/*
        
CMD ["ehforwarderbot"]
