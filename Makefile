NAME    := $(shell sed -n 's/^name *= *"\(.*\)"/\1/p' typst.toml)
VERSION := $(shell sed -n 's/^version *= *"\(.*\)"/\1/p' typst.toml)
DATA_DIR ?= $(or $(XDG_DATA_HOME),$(HOME)/.local/share)
TARGET  := $(DATA_DIR)/typst/packages/local/$(NAME)/$(VERSION)
FILES   := typst.toml README.md lib $(wildcard LICENSE)
TARBALL := dist/$(NAME)-$(VERSION).tar.gz

.PHONY: install link uninstall examples

$(TARBALL): typst.toml README.md $(wildcard LICENSE) $(shell find lib)
	mkdir -p dist && tar -czf $@ $(FILES)

install: $(TARBALL)
	rm -rf "$(TARGET)" && mkdir -p "$(TARGET)"
	tar -xzf $(TARBALL) -C "$(TARGET)"
	@echo 'Installed. Use: #import "@local/$(NAME):$(VERSION)": *'

link:
	rm -rf "$(TARGET)" && mkdir -p "$(dir $(TARGET))"
	ln -s "$(CURDIR)" "$(TARGET)"
	@echo 'Linked. Use: #import "@local/$(NAME):$(VERSION)": *'

uninstall:
	rm -rf "$(TARGET)"

examples:
	typst compile --root . examples/presentation.typ
	typst compile --root . examples/poster.typ
