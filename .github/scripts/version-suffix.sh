#!/bin/bash

GITHUB_SHA_SHORT=$(echo "${GITHUB_SHA}" | head -c 8)

RELEASE_REGEX="refs/heads/release/.*"
FEATURE_REGEX="refs/heads/feature/.*"
HOTFIX_REGEX="refs/heads/hotfix/.*"
BUGFIX_REGEX="refs/heads/bugfix/.*"

if [[ "${GITHUB_REF}" =~ ${FEATURE_REGEX} ]]; then
  VERSION_SUFFIX="feature-${GITHUB_SHA_SHORT}"
elif [[ "${GITHUB_REF}" =~ ${HOTFIX_REGEX} ]]; then
  VERSION_SUFFIX="hotfix-${GITHUB_SHA_SHORT}"
elif [[ "${GITHUB_REF}" =~ ${BUGFIX_REGEX} ]]; then
  VERSION_SUFFIX="bugfix-${GITHUB_SHA_SHORT}"
elif [[ "${GITHUB_REF}" =~ ${RELEASE_REGEX} ]]; then
  VERSION_SUFFIX="release"
else
  if [ -z "${GITHUB_SHA_SHORT}" ] ; then
    VERSION_SUFFIX="develop"
  else
    VERSION_SUFFIX="develop-${GITHUB_SHA_SHORT}"
  fi
fi

echo "${VERSION_SUFFIX}"
