unset PATH
for p in $baseInputs $buildInputs; do
  export PATH=$p/bin${PATH:+:}$PATH
done

function buildPhase() {
  shopt -s globstar

  for md_file in ${src}/**/*.md; do
    no_ending=`echo ${md_file%.md}`
    rel_path=`echo ${no_ending#${src}}`
    html_file="${out}${rel_path}.html"
    html_dir=`dirname $html_file`
    mkdir -p $html_dir
    (
      export TEMPLATE_PATH="${src}/template.html"
      export SOURCE="$md_file"
      export DEST="$html_file"
      renderPage
    )
  done

  shopt -u globstar

  export STRIP_PREFIX=${out}/
  index=$(find ${out} -type f | grep -v index.html | showPosts)
  index_file="${out}/index.html"
  index_dir=`dirname $index_file`
  mkdir -p $index_dir
  echo $index > $index_file

}

function installPhase() {
  echo "Installing..."
}

function genericBuilder() {
  buildPhase
  installPhase
}
