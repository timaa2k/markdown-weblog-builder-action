{ attrsToDirs, bash, coq, fail, git, glibcLocales, haskellPackages, lib,
  libxslt, mkBin, pandocPkgs, python, replace, wget, withNix, xidel }:

let
  renderPage = {
    paths = [ fail pandocPkgs ];
    vars  = {
      defaultTemplate = ../../templates/default.html;
      LANG            = "en_US.UTF-8";
      LOCALE_ARCHIVE  = "${glibcLocales}/lib/locale/locale-archive";
    };
  };

  showPost = {
    paths = [ replace xidel ];
    vars  = {};
  };

  showPosts = {
    paths = [ showPost ];
  };
in {

}
