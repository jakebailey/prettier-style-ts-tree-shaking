.PHONY: all baseline modified prettier

all: baseline modified prettier
	ls -lAh *.min.js

define add_bundle =
$(1).rollup.js: $(1).js
	npx rollup $$< --file $$@ --format=cjs --silent > /dev/null

$(1).rollup.min.js: $(1).rollup.js
	npx esbuild $$< --outfile=$$@ --minify --log-level=error > /dev/null

$(1).terser.js: $(1).js
	npx terser $$< -o $$@ --format=beautify --compress > /dev/null

$(1).terser.min.js: $(1).terser.js
	npx esbuild $$< --outfile=$$@ --minify > /dev/null

$(1): $(1).rollup.min.js $(1).terser.min.js

TARGETS := $(addprefix $(1).terser.min.js , $(TARGETS))
TARGETS := $(addprefix $(1).rollup.min.js , $(TARGETS))
endef

$(eval $(call add_bundle,baseline))
$(eval $(call add_bundle,modified))

prettier.min.js: prettier.js
	npx esbuild $< --outfile=$@ --minify > /dev/null

prettier: prettier.min.js

