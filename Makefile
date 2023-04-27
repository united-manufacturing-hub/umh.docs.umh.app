##@ Module management

.PHONY: module-check
## Check if all of the required submodules are correctly initialized.
module-check: 
	@git submodule status --recursive | awk '/^[+-]/ {err = 1; printf "\033[31mWARNING\033[0m Submodule not initialized: \033[34m%s\033[0m\n",$$2} END { if (err != 0) print "You need to run \033[32mmake module-init\033[0m to initialize missing modules first"; exit err }' 1>&2

.PHONY: module-init
## Initialize required submodules.
module-init: 
	@echo "Initializing submodules..." 1>&2
	@git submodule update --init --recursive --depth 1
	@cd umh.docs.umh.app/themes/docsy && npm install

##@ Build

.PHONY: all
## Build site with production settings and put deliverables in ./public
all: build

.PHONY: build
## Build site with non-production settings and put deliverables in ./public
build: module-check
	cd umh.docs.umh.app && hugo --cleanDestinationDir --minify --environment development

.PHONY: build-preview
## Build site with drafts and future posts enabled
build-preview: module-check 
	cd umh.docs.umh.app && hugo --cleanDestinationDir --buildDrafts --buildFuture --environment preview

.PHONY: production-build
## Build the production site and ensure that noindex headers aren't added
production-build: module-check
	cd umh.docs.umh.app && hugo --cleanDestinationDir --minify --environment production

.PHONY: non-production-build
## Build the non-production site, which adds noindex headers to prevent indexing
non-production-build: module-check 
	cd umh.docs.umh.app && hugo --cleanDestinationDir --enableGitInfo --environment nonprod

.PHONY: serve
## Boot the development server.
serve: module-check
	cd umh.docs.umh.app && hugo server --buildFuture --environment development

##@ Utilities

.PHONY: help
## Display the help
help:
	@awk 'BEGIN { FS = "##"; printf "Usage|make [target] [VAR=VALUE]\n\n" } /^##[^@]/ { c=substr($$0,3); next }\
 		  c && /^[[:upper:]_]+=/ { printf "  \033[36m%s|\033[0m %s. Default %s\n", substr($$1,1,index($$1,"=")-1), c, substr($$1,index($$1,"=")+1,length); c=0 }\
 		  /^##[^@]/ { c=substr($$0,3); next }\
 		  c && /^[[:alnum:]-]+:/ { printf "  \033[36m%s|\033[0m %s\n", substr($$1,1,index($$1,":")-1), c; c=0 }\
 		  /^##@/ { printf "\n\033[32m%s|\033[0m \n", substr($$0, 5) } '\
 		  $(MAKEFILE_LIST) | column -s '|' -t
