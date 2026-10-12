#!/usr/bin/env make

.PHONY: all png tif

FILES   :=
QUALITY := 85

%.png: %.tif
	convert $< $@ 2>&1 >/dev/null

%.jpg: %.png
	guetzli --quality $(QUALITY) --nomemlimit $< $@

all: png tif
png: $(patsubst %.png,%.jpg,$(filter %.png,$(FILES)))
tif: $(patsubst %.tif,%.jpg,$(filter %.tif,$(FILES)))
