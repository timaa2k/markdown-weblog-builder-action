{ attrsToDirs', bash, runCommand, sanitiseName, wrap }:
  with rec {
    go = args: attrsToDirs' args.name {
      bin = builtins.listToAttrs [{
        inherit (args) name;
        value = wrap args;
      }];
    };
  };
  go
