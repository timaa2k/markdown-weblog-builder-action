unset PATH
for p in $baseInputs $buildInputs; do
  export PATH=$p/bin${PATH:+:}$PATH
done

function renderingPhase() {
  ./gen/renderPage
}

function installPhase() {
  echo "Installing..."
}

function staticSiteBuild() {
  renderingPhase
  installPhase
}
