#!/bin/bash

GITHUB_SHA_SHORT=$(echo "${GITHUB_SHA}" | head -c 8)

RELEASE_REGEX="refs/heads/release/.*"
FEATURE_REGEX="refs/heads/feature/.*"
HOTFIX_REGEX="refs/heads/hotfix/.*"
BUGFIX_REGEX="refs/heads/bugfix/.*"

if [[ "${GITHUB_REF}" =~ ${FEATURE_REGEX} ]]; then
  VERSION_SUFIX="feature-${GITHUB_SHA_SHORT}"
elif [[ "${GITHUB_REF}" =~ ${HOTFIX_REGEX} ]]; then
  VERSION_SUFIX="hotfix-${GITHUB_SHA_SHORT}"
elif [[ "${GITHUB_REF}" =~ ${BUGFIX_REGEX} ]]; then
  VERSION_SUFIX="bugfix-${GITHUB_SHA_SHORT}"
elif [[ "${GITHUB_REF}" =~ ${RELEASE_REGEX} ]]; then
  VERSION_SUFIX="bugfix-${GITHUB_SHA_SHORT}"
else
  VERSION_SUFIX="develop-${GITHUB_SHA_SHORT}"
fi

export VERSION_SUFIX

echo "Version Sufix: ${VERSION_SUFIX}"