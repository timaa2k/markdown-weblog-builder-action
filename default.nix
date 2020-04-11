let
  sources = import ./nix/sources.nix;
  overlay = import ./overlay.nix;
  pkgs = import sources.nixpkgs { overlays = [ overlay ]; config = {}; };
in
with pkgs; derivation {
  name = "static-site";
  builder = "${bash}/bin/bash";
  args = [ ./builder.sh ];
  setup = ./setup.sh;
  baseInputs = [
    coreutils
    gnugrep
    bash
    xidel
    pandoc
    glibcLocales
  ];
  buildInputs = [];
  system = builtins.currentSystem;
}
