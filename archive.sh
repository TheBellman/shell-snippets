#!/usr/bin/env bash

URL=$(git config remote.origin.url)
[[ -z ${URL} ]] && exit 1

NAME=$(basename ${URL} |sed 's/\.git$//')

BRANCH=$(git rev-parse --abbrev-ref HEAD)

git archive --verbose --format zip -o ${NAME}-${BRANCH}.zip ${BRANCH}
