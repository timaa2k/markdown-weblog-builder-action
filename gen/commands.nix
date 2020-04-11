{ attrsToDirs, bash, fail, glibcLocales, lib, replace, xidel }:

with builtins;
with lib;
let
  renderPage = {
    paths = [ fail pandoc ];
    vars  = {
      LANG            = "en_US.UTF-8";
      LOCALE_ARCHIVE  = "${glibcLocales}/lib/locale/locale-archive";
    };
  };

  showPost = {
    paths = [ replace xidel ];
  };

  showPosts = {
    paths = [ showPost ];
  };

in {
  renderPage = renderPage;
  showPost = showPost;
  showPosts = showPosts;
}
