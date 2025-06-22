build: build-corne build-reviung41

build-corne:
	nix build .#firmware-aurora-corne

build-reviung41:
	nix build .#firmware-reviung41


upload:
	@echo "Available targets:"
	@grep ^upload- Makefile | sed -e 's/\(.*\):.*/  \1/'

upload-corne:
	# TODO

clean:
	# Nix gc will clean


update:
	nix flake update

#
# TAIPO
#
# TODO: Taipo with Nix
#
#build-taipo: build/taipo-aurora-corne-left.uf2 build/taipo-aurora-corne-right.uf2
#
#build/taipo-aurora-corne-left.uf2: $(SOURCES_TAIPO)
#	rm -f build/taipo-aurora-corne-left.uf2
#	west build \
#		$(WEST_ARGS) \
#		-s $(ZMK_APP_PATH) \
#		-d build/taipo-aurora-corne-left \
#		-b $(BOARD) \
#		-- \
#		-DZMK_CONFIG="$(CONFIG_PATH)/config-taipo" \
#		-DSHIELD=splitkb_aurora_corne_left
#	cp build/taipo-aurora-corne-left/zephyr/zmk.uf2 build/taipo-aurora-corne-left.uf2
#
#build/taipo-aurora-corne-right.uf2: $(SOURCES_TAIPO)
#	rm -f build/taipo-aurora-corne-right.uf2
#	west build \
#		$(WEST_ARGS) \
#		-s $(ZMK_APP_PATH) \
#		-d build/taipo-aurora-corne-right \
#		-b $(BOARD) \
#		-- \
#		-DZMK_CONFIG="$(CONFIG_PATH)/config-taipo" \
#		-DSHIELD=splitkb_aurora_corne_right
#	cp build/taipo-aurora-corne-right/zephyr/zmk.uf2 build/taipo-aurora-corne-right.uf2
#