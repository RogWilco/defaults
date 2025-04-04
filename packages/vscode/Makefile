ROOT_DIR := $(shell pwd)
ROOT_CONFIG := $(ROOT_DIR)/etc/extensions
ROOT_INPUT := $(ROOT_DIR)/etc/template
ROOT_BUILD := $(ROOT_DIR)/var/build
ROOT_DIST := $(ROOT_DIR)/var/dist

clean:
	@ rm -rf \
		node_modules \
		var

validate/%:
	@ bin/validate.sh "$(ROOT_CONFIG)/$(subst *,,$*)"

build/%: node_modules validate/%
	@ bin/generate.ts "$(ROOT_CONFIG)/$(subst *,,$*)" "$(ROOT_INPUT)" "$(ROOT_BUILD)/$(subst *,,$*)"

dist/%: build/%
	@ cd "$(ROOT_BUILD)/$(subst *,,$*)" && \
		vsce package && \
		mkdir -p "$(ROOT_DIST)" && \
		mv *.vsix "$(ROOT_DIST)/"

.PHONY: clean build/% dist/%

node_modules:
	@ bun install
