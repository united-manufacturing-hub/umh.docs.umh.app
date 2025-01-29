#!/bin/bash
set -e

# Ensure Go environment variables are set
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
mkdir -p $GOPATH/bin

# Install Hugo Extended
CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest

# Verify installation
if ! command -v hugo &> /dev/null
then
    echo "Hugo could not be installed"
    exit 1
fi

echo "Hugo Extended installed successfully at $(which hugo)"

echo 'export PATH=$PATH:$GOBIN' >> ~/.bashrc
echo 'export PATH=$PATH:$GOBIN' >> ~/.zshrc
