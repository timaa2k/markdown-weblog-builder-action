with builtins;
with rec {
  inherit (import <nixpkgs> { config = {}; overlays = []; }) fetchgit;

  overlayed = repo: import repo {
    config   = {};
    overlays = [
      (import ./overlay.nix)
      (self: super: {
        # To force -q instead of -s
        inherit (self.nixpkgs1709) xidel;
      })
    ];
  };
};

overlayed (overlayed <nixpkgs>).repo1803
