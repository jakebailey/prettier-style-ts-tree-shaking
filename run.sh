#!/bin/bash

terser() {
    npx terser $1 -o $2 --format=beautify --compress
}

rollup() {
    npx rollup $1 --file $2 --format=cjs
}

echo Creating baseline
terser baseline.js baseline.min.js
rollup baseline.js baseline.rollup.js


# echo Modifying typescript.js
# cp baseline.js typescript.js

# sed -i 's!generateDjb2Hash: \(\)!// \0!g' typescript.js
# sed -i 's!TypeScriptServicesFactory: \(\)!// \0!g' typescript.js
# sed -i 's!Version: \(\)!// \0!g' typescript.js
# sed -i 's!transform: \(\)!// \0!g' typescript.js
# sed -i 's!transform: \(\)!// \0!g' typescript.js

echo Creating typescript
terser typescript.js typescript.min.js
rollup typescript.js typescript.rollup.js
