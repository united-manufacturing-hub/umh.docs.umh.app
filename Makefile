.PHONY: all build build-preview serve

module-init: ## Initialize required submodules.
	@echo "Initializing submodules..." 1>&2
	@git submodule update --init --recursive --depth 1
	@cd umh.docs.umh.app/themes/docsy && npm install

all: build ## Build site with production settings and put deliverables in ./public

build: ## Build site with non-production settings and put deliverables in ./public
	cd umh.docs.umh.app && hugo --cleanDestinationDir --minify --environment development

build-preview: module-check ## Build site with drafts and future posts enabled
	cd umh.docs.umh.app && hugo --cleanDestinationDir --buildDrafts --buildFuture --environment preview

production-build: module-check ## Build the production site and ensure that noindex headers aren't added
	cd umh.docs.umh.app && hugo --cleanDestinationDir --minify --environment production

non-production-build: module-check ## Build the non-production site, which adds noindex headers to prevent indexing
	cd umh.docs.umh.app && hugo --cleanDestinationDir --enableGitInfo --environment nonprod

serve: ## Boot the development server.
	cd umh.docs.umh.app && hugo server --buildFuture --environment development
