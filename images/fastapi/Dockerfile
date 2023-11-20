FROM python:3.11-alpine

ARG USER_HOME="/app"
ARG USER_NAME="app"
ARG USER_UID="1000"
ARG GROUP_NAME="${USER_NAME}"
ARG GROUP_UID="${USER_UID}"

ENV PATH="${PATH}:${USER_HOME}/.local/bin/"

RUN addgroup -g "${GROUP_UID}" "${GROUP_NAME}" && \
    adduser -G "${GROUP_NAME}" -s /bin/bash -u "${USER_UID}" -h "${USER_HOME}" "${USER_NAME}" -D

RUN apk update && \
    apk add bash

SHELL ["/bin/bash", "-c"]

RUN apk add bind-tools iperf3 busybox-extras curl fio

COPY docker-entrypoint.sh /

WORKDIR "${USER_HOME}"
USER "${USER_NAME}"

COPY ./src/* .

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --upgrade hypercorn uvicorn fastapi

ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
