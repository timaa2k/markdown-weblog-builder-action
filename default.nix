let
  sources = import ./nix/sources.nix;
  overlay = import ./overlay.nix;
  pkgs = import sources.nixpkgs { overlays = [ overlay ]; config = {}; };
in
with pkgs; derivation {
  name = "static-site";
  src = ./src;
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
    findutils
    python3.7
    curl
  ];
  buildInputs = [
    showPost
    showPosts
    renderPage
  ];
  system = builtins.currentSystem;
}
