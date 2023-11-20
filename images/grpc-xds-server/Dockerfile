FROM python:3.10-alpine

ARG USER_HOME="/app"
ARG USER_NAME="grpc"
ARG USER_UID="1000"
ARG GROUP_NAME="${USER_NAME}"
ARG GROUP_UID="${USER_UID}"

RUN addgroup -g "${GROUP_UID}" "${GROUP_NAME}" && \
    adduser -G "${GROUP_NAME}" -s /bin/bash -u "${USER_UID}" -h "${USER_HOME}" "${USER_NAME}" -D

RUN apk update && \
    apk add bash

SHELL ["/bin/bash", "-c"]

COPY docker-entrypoint.sh /

WORKDIR "${USER_HOME}"
USER "${USER_NAME}"

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --upgrade grpcio grpcio-tools grpcio-reflection grpcio-health-checking protobuf

COPY src .

ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]