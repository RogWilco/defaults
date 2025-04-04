ROOT_DIR := $(shell pwd)
ROOT_CONFIG := $(ROOT_DIR)/etc/extensions
ROOT_INPUT := $(ROOT_DIR)/etc/template
ROOT_BUILD := $(ROOT_DIR)/var/build
ROOT_DIST := $(ROOT_DIR)/var/dist

clean:
	@ rm -rf \
		node_modules \
		var

build/%: node_modules
	$(eval PACK_NAME := $(subst *,,$*))
	$(eval DIR_CONFIG := $(ROOT_CONFIG)/$(PACK_NAME))
	$(eval DIR_INPUT := $(ROOT_INPUT))
	$(eval DIR_OUTPUT := $(ROOT_BUILD)/$(PACK_NAME))

	@bin/generate.ts "$(DIR_CONFIG)" "$(DIR_INPUT)" "$(DIR_OUTPUT)"

dist/%: build/%
	$(eval PACK_NAME := $(subst *,,$*))
	$(eval DIR_BUILD := $(ROOT_BUILD)/$(PACK_NAME))
	$(eval DIR_DIST := $(ROOT_DIST))

	@ cd "$(DIR_BUILD)" && \
		vsce package && \
		mkdir -p "$(DIR_DIST)" && \
		mv *.vsix "$(DIR_DIST)/"

.PHONY: clean build/% dist/%

node_modules:
	@ bun install
