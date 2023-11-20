FROM alpine:latest

ARG USER_HOME="/tmp/debug"
ARG USER_NAME="debug"
ARG USER_UID="1000"
ARG GROUP_NAME="${USER_NAME}"
ARG GROUP_UID="${USER_UID}"

ARG KUBECTL_VERSION="1.25.3"

RUN addgroup -g "${GROUP_UID}" "${GROUP_NAME}" && \
    adduser -G "${GROUP_NAME}" -s /bin/bash -u "${USER_UID}" -h "${USER_HOME}" "${USER_NAME}" -D

RUN apk update && \
    apk add bash

SHELL ["/bin/bash", "-c"]

RUN apk add bind-tools iperf3 busybox-extras curl fio

RUN wget "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" -O /usr/local/bin/kubectl && \
    chmod 0755 /usr/local/bin/kubectl

COPY docker-entrypoint.sh /

WORKDIR "${USER_HOME}"
USER "${USER_NAME}"

ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
