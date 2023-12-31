#WEST_ARGS=--pristine

SOURCES = $(wildcard config/*)
SOURCES_TAIPO = $(wildcard config-taipo/*)

build: build-left build-right

build-left: build/splitkb_aurora_corne_left.uf2
build-right: build/splitkb_aurora_corne_right.uf2

build/%.uf2: $(SOURCES)
	rm -f build/$*.uf2
	west build \
		$(WEST_ARGS) \
		-s /workspaces/zmk/app \
		-d build/$* \
		-b nice_nano_v2 \
		-- \
		-DZMK_CONFIG="/workspaces/zmk-config/config" \
		-DSHIELD=$*
	cp build/$*/zephyr/zmk.uf2 build/$*.uf2

clean:
	rm -fr build/*.uf2

purge:
	rm -fr build

#
# TAIPO
#

build-taipo: build/taipo-aurora-corne-left.uf2 build/taipo-aurora-corne-right.uf2

build/taipo-aurora-corne-left.uf2: $(SOURCES_TAIPO)
	rm -f build/taipo-aurora-corne-left.uf2
	west build \
		$(WEST_ARGS) \
		-s /workspaces/zmk/app \
		-d build/taipo-aurora-corne-left \
		-b nice_nano_v2 \
		-- \
		-DZMK_CONFIG="/workspaces/zmk-config/config-taipo" \
		-DSHIELD=splitkb_aurora_corne_left
	cp build/taipo-aurora-corne-left/zephyr/zmk.uf2 build/taipo-aurora-corne-left.uf2

build/taipo-aurora-corne-right.uf2: $(SOURCES_TAIPO)
	rm -f build/taipo-aurora-corne-right.uf2
	west build \
		$(WEST_ARGS) \
		-s /workspaces/zmk/app \
		-d build/taipo-aurora-corne-right \
		-b nice_nano_v2 \
		-- \
		-DZMK_CONFIG="/workspaces/zmk-config/config-taipo" \
		-DSHIELD=splitkb_aurora_corne_right
	cp build/taipo-aurora-corne-right/zephyr/zmk.uf2 build/taipo-aurora-corne-right.uf2
