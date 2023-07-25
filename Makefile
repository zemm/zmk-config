#WEST_ARGS=--pristine

SOURCES = $(wildcard config/*)

build: build-left build-right

build-left: build/left.uf2
build-right: build/right.uf2

build/left.uf2: $(SOURCES)
	rm -f build/left.uf2
	west build \
		$(WEST_ARGS) \
		-s /workspaces/zmk/app \
		-d build/left \
		-b nice_nano_v2 \
		-- \
		-DZMK_CONFIG="/workspaces/zmk-config/config" \
		-DSHIELD=splitkb_aurora_corne_left
	cp build/left/zephyr/zmk.uf2 build/left.uf2

build/right.uf2: $(SOURCES)
	rm -f build/right.uf2
	west build \
		$(WEST_ARGS) \
		-s /workspaces/zmk/app \
		-d build/right \
		-b nice_nano_v2 \
		-- \
		-DZMK_CONFIG="/workspaces/zmk-config/config" \
		-DSHIELD=splitkb_aurora_corne_right
	cp build/right/zephyr/zmk.uf2 build/right.uf2
