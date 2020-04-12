let
  sources = import ./nix/sources.nix;
  overlay = import ./overlay.nix;
  pkgs = import sources.nixpkgs { overlays = [ overlay ]; config = {}; };

  src = pkgs.fetchgit {
    url    = "https://github.com/timaa2k/posts";
    branchName = "master";
    rev    = "HEAD";
    sha256 = "1192iphwbyqj7ddz7wx1qi0dyanckwv50rg9y9p5xgcjg1ajffwf";
    leaveDotGit = true;
    deepClone = true;
  };
in
with pkgs; derivation {
  name = "static-site";
  src = src;
  builder = "${bash}/bin/bash";
  args = [ ./builder.sh ];
  setup = ./setup.sh;
  baseInputs = [
    coreutils
    gnugrep
    gnused
    bash
    xidel
    pandoc
    findutils
    utillinux
    python3.7
    git
  ];
  buildInputs = [
    showPost
    showPosts
    renderPage
  ];
  system = builtins.currentSystem;
}
