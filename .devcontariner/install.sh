#!/bin/bash

export TASKFILE_INSTALL_SCRIPT="https://taskfile.dev/install.sh"
export HUGO_INSTALLATION_PKG="https://github.com/gohugoio/hugo/releases/download/v0.145.0/hugo_0.145.0_linux-amd64.deb"

sh -c "$(curl --location ${TASKFILE_INSTALL_SCRIPT})" -- -d -b /usr/bin/

wget ${HUGO_INSTALLATION_PKG}

dpkg -i hugo_0.145.0_linux-amd64.deb && rm hugo_0.145.0_linux-amd64.deb