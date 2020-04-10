unset PATH
for p in $baseInputs $buildInputs; do
  export PATH=$p/bin${PATH:+:}$PATH
done

function buildPhase() {}

function installPhase() {}

function fixupPhase() {}

function staticSiteBuild() {
  buildPhase
  installPhase
  fixupPhase
}
