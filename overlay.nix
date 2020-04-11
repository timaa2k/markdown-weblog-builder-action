with builtins;

self: super: {
  showPost = self.writeScriptBin "showPost" (readFile ./cmd/showPost);
  showPosts = self.writeScriptBin "showPosts" (readFile ./cmd/showPosts);
  renderPage = self.writeScriptBin "renderPage" (readFile ./cmd/renderPage);
}
