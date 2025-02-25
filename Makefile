# Makefile for building and deploying Hugo website

# make serve should be everything you need as a developer

# Default variables
HUGO_ENV ?= production
HUGO_VERSION ?= v0.111.3
NODE_VERSION ?= v18.16.0
SKIP_IMAGE_OPTIMIZATION ?= false

# Ensure /bin/bash is used
SHELL := /bin/bash

# Ensure /usr/local/bin is in PATH
PATH := /usr/local/bin:$(PATH)

install-and-serve: install serve

# Check Hugo and Node.js versions
check_versions:
	@echo "Checking Hugo and Node.js versions..."
	@if hugo version | grep -q $(HUGO_VERSION); then \
		echo "Correct Hugo version installed"; \
	else \
		echo "Incorrect Hugo version, installing..."; \
		if [ "$$(uname)" = "Darwin" ]; then \
			wget https://github.com/gohugoio/hugo/releases/download/$(HUGO_VERSION)/hugo_extended_$(shell echo $(HUGO_VERSION) | cut -c 2-)_darwin-universal.tar.gz && \
			tar -xzf hugo_extended_$(shell echo $(HUGO_VERSION) | cut -c 2-)_darwin-universal.tar.gz && \
			sudo mv hugo /usr/local/bin/ && \
			rm -f hugo_extended_$(shell echo $(HUGO_VERSION) | cut -c 2-)_darwin-universal.tar.gz LICENSE README.md; \
		else \
			wget https://github.com/gohugoio/hugo/releases/download/$(HUGO_VERSION)/hugo_extended_$(shell echo $(HUGO_VERSION) | cut -c 2-)_linux-amd64.deb && \
			(sudo dpkg -i hugo_extended_$(shell echo $(HUGO_VERSION) | cut -c 2-)_linux-amd64.deb) || (dpkg -i hugo_extended_$(shell echo $(HUGO_VERSION) | cut -c 2-)_linux-amd64.deb) && \
			rm hugo_extended_$(shell echo $(HUGO_VERSION) | cut -c 2-)_linux-amd64.deb; \
		fi; \
	fi

	@if node -v | grep -q $(NODE_VERSION); then \
		echo "Correct Node version installed"; \
	else \
		echo "Incorrect Node version..."; \
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash && \
		. ~/.nvm/nvm.sh && \
		(echo "Switching to the right version..." && nvm use $(NODE_VERSION) ) || (echo "Incorrect Node version, installing..." && nvm install $(NODE_VERSION) && nvm use $(NODE_VERSION)); \
	fi

install_docsy:
	@cd umh.docs.umh.app/themes/docsy && npm install

install_postcss:
	@cd umh.docs.umh.app && npm install postcss-cli autoprefixer

install_submodules:
	@git submodule update -f --init --recursive

# Master install target
install: check_versions install_submodules install_docsy install_postcss
	@echo "All dependencies installed."

# Serve the Hugo site
serve:
	@echo "Serving site..."
	@cd umh.docs.umh.app && hugo serve -D

# Build the Hugo site
build-cloudflare:
	@echo "Building site..."
	@cd umh.docs.umh.app && \
		([[ "$(SKIP_IMAGE_OPTIMIZATION)" == "false" ]] && \
		(cd ./static/images && npx --yes avif --overwrite --verbose --input="**/*.{jpg,png}" && cd ../..) || \
		echo "Skipping image optimization") && \
		hugo --gc --minify

# Production build
build-production: 
	@echo "Production build..."
	$(MAKE) build-cloudflare HUGO_ENV=production SKIP_IMAGE_OPTIMIZATION=false

# Preview build
build-preview: 
	@echo "Preview build..."
	$(MAKE) build-cloudflare HUGO_ENV=production SKIP_IMAGE_OPTIMIZATION=true
