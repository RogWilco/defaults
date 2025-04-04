ROOT_DIR := $(shell pwd)
ROOT_CONFIG := $(ROOT_DIR)/etc/extensions
ROOT_INPUT := $(ROOT_DIR)/etc/template
ROOT_BUILD := $(ROOT_DIR)/var/build
ROOT_DIST := $(ROOT_DIR)/var/dist

## Clean up all generated files
clean:
	@ rm -rf \
		node_modules \
		var

## Validate all extensions
validate:
	@ for extension in $(wildcard $(ROOT_CONFIG)/*); do \
		extname=$$(basename $$extension); \
		$(MAKE) validate/$$extname; \
	done

## Validate a specific extension
validate/%:
	@ bin/validate.sh "$(ROOT_CONFIG)/$(subst *,,$*)"

## Build all extensions
build:
	@ for extension in $(wildcard $(ROOT_CONFIG)/*); do \
		extname=$$(basename $$extension); \
		$$(MAKE) build/$$extname; \
	done

## Build a specific extension
build/%: node_modules validate/%
	@ bin/generate.ts "$(ROOT_CONFIG)/$(subst *,,$*)" "$(ROOT_INPUT)" "$(ROOT_BUILD)/$(subst *,,$*)"

dist:
	@ for extension in $(wildcard $(ROOT_CONFIG)/*); do \
		extname=$$(basename $$extension); \
		$(MAKE) dist/$$extname; \
	done

## Create the distributable for a specific extension
dist/%: build/%
	@ cd "$(ROOT_BUILD)/$(subst *,,$*)" && \
		vsce package && \
		mkdir -p "$(ROOT_DIST)" && \
		mv *.vsix "$(ROOT_DIST)/"

.PHONY: clean validate validate/% build/% dist/%

node_modules:
	@ bun install
