{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    zmk-nix = {
      url = "github:lilyinstarlight/zmk-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, zmk-nix }: let
    forAllSystems = nixpkgs.lib.genAttrs (nixpkgs.lib.attrNames zmk-nix.packages);

    sourceFileList = [
      ".board" ".cmake" ".conf" ".defconfig" ".dts" ".dtsi" ".json"
      ".keymap" ".overlay" ".shield" ".yml" "_defconfig" ".h"
    ];
  in {
    packages = forAllSystems (system: rec {
      default = firmware;

      # Bump West dependencies zephyrDepsHash of .#firmware
      update = zmk-nix.packages.${system}.update;

      # Flashing
      flash-reviung41 = zmk-nix.packages.${system}.flash.override {
        firmware = firmware-reviung41;
      };
      flash-aurora-corne = zmk-nix.packages.${system}.flash.override {
        firmware = firmware-reviung41;
      };

      # Firmwares
      firmware-reviung41 = zmk-nix.legacyPackages.${system}.buildKeyboard {
        name = "firmware-reviung41";

        board = "sparkfun_pro_micro_rp2040";
        shield = "reviung41";

        src = nixpkgs.lib.sourceFilesBySuffices self sourceFileList;
        zephyrDepsHash = firmware.zephyrDepsHash;
      };

      firmware-aurora-corne = zmk-nix.legacyPackages.${system}.buildSplitKeyboard {
        name = "firmware-aurora-corne";

        board = "nice_nano_v2";
        shield = "splitkb_aurora_corne_%PART%";

        src = nixpkgs.lib.sourceFilesBySuffices self sourceFileList;
        zephyrDepsHash = firmware.zephyrDepsHash;
      };

      firmware = {
        zephyrDepsHash = "sha256-k0BrCX7Pspj6/SSOgKSlDW1jZ3OWTFy5f8Kr+vQJ1LU=";
      };
    });

    devShells = forAllSystems (system: {
      default = zmk-nix.devShells.${system}.default;
    });
  };
}
