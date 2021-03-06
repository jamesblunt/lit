APP_FILES=$(shell find . -name '*.lua')
LUVI_ARCH=$(shell uname -s)_$(shell uname -m)
LUVI_VERSION=2.0.9
LUVI_URL=https://github.com/luvit/luvi/releases/download/v$(LUVI_VERSION)/luvi-regular-$(LUVI_ARCH)

lit: luvi $(APP_FILES)
	./luvi . -- make

luvi:
	curl -L $(LUVI_URL) > luvi
	chmod +x luvi

test: lit
	tests/run.sh

clean:
	rm -rf lit luvi test-offline test-pull test-push test-server

install: lit
	install lit /usr/local/bin

deploy: lit
	sudo systemctl stop lit
	install lit /usr/local/bin
	sudo systemctl start lit

uninstall:
	rm -f /usr/local/bin/lit

lint:
	luacheck $(APP_FILES)
