.PHONY: check fmt

check:
	stylua --check .
	luacheck .
	d=$$(mktemp -d); ln -s "$(CURDIR)" "$$d/nvim"; XDG_CONFIG_HOME="$$d" nvim --headless -i NONE -c 'qa!'; r=$$?; rm -rf "$$d"; exit $$r

fmt:
	stylua .
