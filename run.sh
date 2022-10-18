#!/bin/bash

set -x

esbuild() {
    npx esbuild $1 --outfile=$2 --minify
}

terser() {
    npx terser $1 -o $2 --format=beautify --compress
    esbuild $2 $3
}

rollup() {
    npx rollup $1 --file $2 --format=cjs
    esbuild $2 $3
}

terser baseline.js baseline.terser.js baseline.terser.min.js
rollup baseline.js baseline.rollup.js baseline.rollup.min.js


# echo Modifying typescript.js
# cp baseline.js typescript.js

# sed -i 's!generateDjb2Hash: \(\)!// \0!g' typescript.js
# sed -i 's!TypeScriptServicesFactory: \(\)!// \0!g' typescript.js
# sed -i 's!Version: \(\)!// \0!g' typescript.js
# sed -i 's!transform: \(\)!// \0!g' typescript.js
# sed -i 's!transform: \(\)!// \0!g' typescript.js

terser typescript.js typescript.terser.js typescript.terser.min.js
rollup typescript.js typescript.rollup.js typescript.rollup.min.js

esbuild prettier-modified-typescript.js prettier-modified-typescript.min.js
