{ paths ? [], vars ? {}, file ? null, script ? null, name ? "wrap", pkgs ? <nixpkgs> }:
  with pkgs;
  assert file != null || script != null ||
         abort "wrap needs 'file' or 'script' argument";
  with rec {
    set  = n: v: "--set ${escapeShellArg (escapeShellArg n)} " +
                   "'\"'${escapeShellArg (escapeShellArg v)}'\"'";
    args = (map (p: "--prefix PATH : ${p}/bin") paths) ++
           (attrValues (mapAttrs set vars));
  };
  runCommand name
    {
      f           = if file == null then writeScript name script else file;
      buildInputs = [ makeWrapper ];
    }
    ''
      makeWrapper "$f" "$out" ${toString args}
    '';
