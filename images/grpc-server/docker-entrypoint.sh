#!/bin/bash

CONF_COLORS="$CONF_COLORS"

function logger_format() {
  DATE=$(date +"%Y-%m-%d %H:%M:%S,%3N")

  if [[ "${CONF_COLORS}" == "true" ]]; then
    echo -e "${DATE} \e[${3}m${1}\e[m\t ${2}"
  else
    echo -e "${DATE} ${1}\t ${2}"
  fi
}

function logger_msg() {
  if [ "${2}" == "error" ]; then
    logger_format "ERROR" "${1}" "91"
  elif [ "${2}" == "success" ]; then
    logger_format "SUCCESS" "${1}" "92"
  elif [ "${2}" == "warning" ]; then
    logger_format "WARNING" "${1}" "93"
  elif [ "${2}" == "info" ]; then
    logger_format "INFO" "${1}" "96"
  else
    logger_format "LOGGER" "Incorrect logger type: '${2}'.." "31" && exit 4
  fi
}

function logger() {
  [ "${#}" -lt 2 ] || [ "${#}" -gt 2 ] && exit 1

  logger_msg "${2}" "${1}"
}

# Defaults

if [ -z "${LISTEN_PORT}" ]; then
  logger info "'LISTEN_PORT' is not set, using default port '9000'"

  LISTEN_PORT="9000"
fi

# Main

logger info "Starting unsecured port on '${LISTEN_PORT}'.."

if [ ! -z "${LISTEN_PORT_TLS}" ]; then
  logger info "Starting secured port on '${LISTEN_PORT_TLS}'.."
fi

python3 -u server.py
