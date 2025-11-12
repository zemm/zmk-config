TARGETS=aurora_corne reviung41 bkd_xiao_ble

.PHONY: all build upload clean update

build: $(addprefix build/,$(TARGETS))

build/%: Makefile flake.nix flake.lock
	echo "Building firmware for target: $*"
	if command -v nom > /dev/null; then \
		nom build --out-link $@ .#firmware-$*; \
	else \
		nix build --out-link $@ .#firmware-$*; \
	fi

flash:
	@echo "Available targets:"
	@for target in $(TARGETS); do \
		echo "  flash/$$target"; \
	done

flash/%: build/%
	nix run .#flash-$*

clean:
	# Nix gc will clean data
	rm -fr build

update: update-flake update-firmware

update-flake:
	nix flake update

update-firmware:
	# @TODO: update-firmware is not working atm
	#
	#for target in $(TARGETS); do \
	#	echo "Updating firmware for target: $$target"; \
	#	UPDATE_NIX_ATTR_PATH=firmware-$$target nix run .#update; \
	#done

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