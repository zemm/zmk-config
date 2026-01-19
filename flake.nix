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

    zephyrDepsHash = "sha256-Fz6NJI4wmRiv2x3KSrXF7Gk92zQZOjzBlP96g562mFQ=";
  in {
    packages = forAllSystems (system: rec {
      default = firmware-aurora_corne;

      # Bump West dependencies zephyrDepsHash of .#firmware
      update = zmk-nix.packages.${system}.update;

      # Flashing
      flash-reviung41 = zmk-nix.packages.${system}.flash.override {
        firmware = firmware-reviung41;
      };

      flash-aurora_corne = zmk-nix.packages.${system}.flash.override {
        firmware = firmware-aurora_corne;
      };

      flash-kyria = zmk-nix.packages.${system}.flash.override {
        firmware = firmware-kyria;
      };

      flash-tbk_xiao_ble = zmk-nix.packages.${system}.flash.override {
        firmware = firmware-tbk_xiao_ble;
      };

      # Firmwares
      firmware-reviung41 = zmk-nix.legacyPackages.${system}.buildKeyboard {
        name = "firmware-reviung41";
        board = "sparkfun_pro_micro_rp2040";
        shield = "reviung41";
        src = nixpkgs.lib.sourceFilesBySuffices self sourceFileList;
        inherit zephyrDepsHash;
      };

      firmware-reviung41z = zmk-nix.legacyPackages.${system}.buildKeyboard {
        name = "firmware-reviung41z";
        board = "sparkfun_pro_micro_rp2040";
        shield = "reviung41z";
        src = nixpkgs.lib.sourceFilesBySuffices self sourceFileList;
        inherit zephyrDepsHash;
      };

      firmware-aurora_corne = zmk-nix.legacyPackages.${system}.buildSplitKeyboard {
        name = "firmware-aurora_corne";
        board = "nice_nano_v2";
        shield = "splitkb_aurora_corne_%PART%";
        src = nixpkgs.lib.sourceFilesBySuffices self sourceFileList;
        inherit zephyrDepsHash;
      };

      firmware-kyria = zmk-nix.legacyPackages.${system}.buildSplitKeyboard {
        name = "firmware-kyria";
        board = "nice_nano_v2";
        shield = "kyria_rev2_%PART%";
        src = nixpkgs.lib.sourceFilesBySuffices self sourceFileList;
        inherit zephyrDepsHash;
      };

      firmware-tbk_xiao_ble = zmk-nix.legacyPackages.${system}.buildSplitKeyboard {
        name = "firmware-tbk_xiao_ble";
        board = "seeeduino_xiao_ble";
        shield = "tbk_xiao_ble_%PART%";
        src = nixpkgs.lib.sourceFilesBySuffices self sourceFileList;
        inherit zephyrDepsHash;
      };
    });

    devShells = forAllSystems (system: {
      default = zmk-nix.devShells.${system}.default;
    });
  };
}
