#WEST_ARGS=--pristine

SOURCES = $(wildcard config/*)
SOURCES_TAIPO = $(wildcard config-taipo/*)

ZMK_PATH := /workspaces/zmk
ZMK_APP_PATH := /workspaces/zmk/app
CONFIG_PATH := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

BOARD = nice_nano_v2

.ONESHELL:

build: corne


corne: corne-left corne-right

corne-left: BOARD=nice_nano_v2
corne-left: build/splitkb_aurora_corne_left.uf2
corne-right: BOARD=nice_nano_v2
corne-right: build/splitkb_aurora_corne_right.uf2


reviung41: BOARD=sparkfun_pro_micro_rp2040
reviung41: build/reviung41.uf2

build/%.uf2: $(SOURCES)
	#cd $(ZMK_PATH)
	mkdir -p build
	rm -f build/$*.uf2
	west build \
		$(WEST_ARGS) \
		-s $(ZMK_APP_PATH) \
		-d build/$* \
		-b $(BOARD) \
		-- \
		-DZMK_CONFIG="$(CONFIG_PATH)/config" \
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
		-s $(ZMK_APP_PATH) \
		-d build/taipo-aurora-corne-left \
		-b $(BOARD) \
		-- \
		-DZMK_CONFIG="$(CONFIG_PATH)/config-taipo" \
		-DSHIELD=splitkb_aurora_corne_left
	cp build/taipo-aurora-corne-left/zephyr/zmk.uf2 build/taipo-aurora-corne-left.uf2

build/taipo-aurora-corne-right.uf2: $(SOURCES_TAIPO)
	rm -f build/taipo-aurora-corne-right.uf2
	west build \
		$(WEST_ARGS) \
		-s $(ZMK_APP_PATH) \
		-d build/taipo-aurora-corne-right \
		-b $(BOARD) \
		-- \
		-DZMK_CONFIG="$(CONFIG_PATH)/config-taipo" \
		-DSHIELD=splitkb_aurora_corne_right
	cp build/taipo-aurora-corne-right/zephyr/zmk.uf2 build/taipo-aurora-corne-right.uf2
