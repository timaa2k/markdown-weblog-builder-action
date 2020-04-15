let
  sources = import ./nix/sources.nix;
  overlay = import ./overlay.nix;
  pkgs = import sources.nixpkgs { overlays = [ overlay ]; config = {}; };

  staticSiteTheme = pkgs.srcOnly {
    name = "static-site-theme";
    src = ./. + "/theme";
  };

  staticSitePosts = pkgs.srcOnly {
    name = "markdown-files";
    src = builtins.getEnv "MARKDOWN_DIR";
  };

  staticSite = pkgs.stdenvNoCC.mkDerivation {
    name = "static-site";
    src = [ staticSiteTheme staticSitePosts ];
    sourceRoot = ".";
    nativeBuildInputs = with pkgs; [
      bash
      coreutils
      gnugrep
      gnused
      xidel
      pandoc
      findutils
      utillinux
      git
      showPost
      showPosts
      renderPage
    ];
    installPhase = ''
      export BASE_PATH="${builtins.getEnv "BASE_PATH"}"

      shopt -s globstar

      for md_file in ${staticSitePosts}/**/*.md; do
        no_ending=`echo "''${md_file%.md}"`
        rel_path=`echo "''${no_ending#${staticSitePosts}}"`
        html_file="''${out}''${rel_path}.html"
        html_dir=`dirname "$html_file"`
        mkdir -p "$html_dir"

        history_link="''${rel_path}-history.html"
        history_file="''${out}''${history_link}"

        git -C ${staticSitePosts} log --date=short --pretty=format:"%ad" --unified=0 -p $md_file | sed -e '/diff/,/@@/d' -e 's/^/<p>/' -e 's/$/<\/p>/' > $history_file
        (
          export HISTORY_HREF="''${BASE_PATH}''${history_link}"
          export TEMPLATE_PATH="${staticSiteTheme}/template.html"
          export SOURCE="$md_file"
          export DEST="$html_file"
          renderPage
        )
      done

      shopt -u globstar

      export STRIP_PREFIX="$out/"
      index=$(find $out -type f -name \*.html | grep -v index.html | grep -v history | showPosts)
      index_file="''${out}/index.html"
      index_dir=`dirname "$index_file"`
      mkdir -p "$index_dir"
      echo "$index" > "$index_file"

      cp ${staticSiteTheme}/style.css "''${out}/style.css"
    '';
  };
in
let
  server = pkgs.writeShellScriptBin "serveStaticSite" ''
    echo "Running server: http://localhost:8000/"
    ${pkgs.webfs}/bin/webfsd -F -p 8000 -r ${staticSite}
  '';
in
  if pkgs.lib.inNixShell
  then pkgs.mkShell {
    buildInputs = [ server ];
    shellHook = ''
      ${server}/bin/serveStaticSite
    '';
  }
  else staticSite
