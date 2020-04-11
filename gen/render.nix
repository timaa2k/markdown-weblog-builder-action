{ callPackage, commands, fail, lib, runCommand, writeScript }:

with builtins;
with lib;

{ file, inputs ? [], name, SOURCE_PATH, TO_ROOT ? "", vars ? {} }:
  with rec {
    rendered  = runCommand name
      (vars // {
        inherit dir file SOURCE_PATH TO_ROOT;
        __noChroot    = true;
        buildInputs   = inputs ++ [ commands.renderPage fail ];
        postprocessor = "";
      })
      ''
        export DEST="$PWD/out.html"

        cd "$dir"
        SOURCE="$file" renderPage
        grep '^.' < "$DEST" > /dev/null || fail "Error: No output when rendering"

        relativise < "$DEST" > "$out"
      '';

    output = if hasSuffix ".html" file
                then with { data = writeScript name (readFile file); };
                     if TO_ROOT == ""
                        then data
                        else relTo TO_ROOT data
                else rendered;
  };
  nonempty { inherit name; file = output; }
