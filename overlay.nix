self: super: {
  wrap = import ./helpers/wrap.nix {};
  mkBin = import ./helpers/mkBin.nix {};
  fail = import ./helpers/fail.nix {};
}
