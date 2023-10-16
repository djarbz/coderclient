#!/usr/bin/env bash

# errexit (-e): Exit on non-zero exit status.
set -e
# nounset (-u): Exit on uninitialized variables.
set -u
# pipefail (-o pipefail): Exit on non-zero exit status in pipelines.
set -o pipefail
# xtrace (-x): Print commands before execution for debugging purposes.
# set -x

APP_NAME="${1}"
shift
APP_URL="${1}"
shift

BUILD_DIR="build"
mkdir -p "${BUILD_DIR}"

HEAD="$(curl -fsSL "${APP_URL}" | pup 'head')"
if [ -z "${HEAD}" ]; then
  echo "Failed to query ${APP_URL}"
  exit 1
fi

APPLE_ICON="$(echo "${HEAD}" | pup 'link[rel="apple-touch-icon"] attr{href}')"
FAV_ICON="$(echo "${HEAD}" | pup 'link[rel="icon"] attr{href}')"
ICON=""

if [ -n "${APPLE_ICON}" ]; then
  ICON_URL=$(echo "${APPLE_ICON}" | sed '1p;d')
  echo "Using Apple Touch Icon... ${ICON_URL}"
elif [ -n "${FAV_ICON}" ]; then
  ICON_URL=$(echo "${FAV_ICON}" | sed '1p;d')
  echo "Using Favicon... ${ICON_URL}"
else
  echo "ICON not found on ${APP_URL}"
  exit 1
fi
ICON="${BUILD_DIR}/${APP_NAME}_$(basename "${ICON_URL}")"
curl -fsSL -o "${BUILD_DIR}/${APP_NAME}_$(basename "${ICON_URL}")" "${APP_URL}${ICON_URL}"

# shellcheck disable=SC2068
nativefier \
  --platform windows \
  --arch x64 \
  --maximize \
  --show-menu-bar \
  --build-version "$(date +%y.%m.%db%H%M)" \
  --file-download-options '{"saveAs": true}' \
  --name "${APP_NAME}" \
  --icon "${ICON}" \
  ${@} \
  "${APP_URL}" \
  ${BUILD_DIR}
