#!/bin/bash

echo Creating baseline.min.js
time npx terser baseline.js -o baseline.min.js --format=beautify --compress
echo Creating typescript.min.js
time npx terser typescript.js -o typescript.min.js --format=beautify --compress
