#!/bin/bash
set -e

HUGO_VERSION=v0.111.3

# Ensure Go environment variables are set
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
mkdir -p $GOPATH/bin

# Install Hugo Extended
CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@$HUGO_VERSION

echo 'export PATH=$PATH:$GOBIN' >> ~/.bashrc
echo 'export PATH=$PATH:$GOBIN' >> ~/.zshrc

echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.zshrc

# Source the bashrc or zshrc file (depending on the shell)
source ~/.bashrc

# Verify installation
if ! command -v $HOME/go/bin/hugo &> /dev/null
then
    echo "Hugo could not be installed"
    exit 1
fi

echo "Hugo Extended installed successfully at $(which $HOME/go/bin/hugo)"
