#!/usr/bin/env bash

PACKAGE=AWSCLIV2.pkg

cd /tmp
curl "https://awscli.amazonaws.com/${PACKAGE}" -o "${PACKAGE}"
sudo installer -pkg ${PACKAGE} -target /
rm -f ${PACKAGE}
