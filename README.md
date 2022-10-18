# Prettier-style typescript.js internal tree shaking

This is a PoC to show how one might remove unused code from within
`typescript.js` in a way similar to the hack done in
[prettier](https://github.com/prettier/prettier/blob/main/scripts/build/modify-typescript-module.mjs)
now that the file is bundled and not namespaces. In general,
the approach is to remove pieces of code from the bundle, then run rollup or
terser over the output to make use of their dead code removal.

This gives an output which is smaller that the output currently used by prettier.

Minified with esbuild for comparison:

```
ls -lAhS *.js 
-rw-r--r-- 1 jabaile jabaile  7.3M Oct 18 15:25 modified.js
-rw-r--r-- 1 jabaile jabaile  7.3M Oct 18 14:45 baseline.js
-rw-r--r-- 1 jabaile jabaile  7.3M Oct 18 14:45 baseline.rollup.js
-rw-r--r-- 1 jabaile jabaile  6.8M Oct 18 14:45 baseline.terser.js
-r--r--r-- 1 jabaile jabaile  2.9M Oct 18 14:15 prettier.js
-rw-r--r-- 1 jabaile jabaile  2.9M Oct 18 14:45 baseline.rollup.min.js
-rw-r--r-- 1 jabaile jabaile  2.8M Oct 18 14:45 baseline.terser.min.js
-rw-r--r-- 1 jabaile jabaile  2.3M Oct 18 15:26 modified.rollup.js
-rw-r--r-- 1 jabaile jabaile  2.0M Oct 18 15:26 modified.terser.js
-rw-r--r-- 1 jabaile jabaile  1.2M Oct 18 14:15 prettier.min.js
-rw-r--r-- 1 jabaile jabaile 1023K Oct 18 15:26 modified.terser.min.js
-rw-r--r-- 1 jabaile jabaile  989K Oct 18 15:26 modified.rollup.min.js
```

One can diff `baseline.js` and `modified.js` to see the difference.

`rollup` seems to be the faster of the two; esbuild doesn't do this kind of optimization.

```
npx terser modified.js -o modified.terser.js --compress > /dev/null
make modified.terser.js  10.97s user 0.34s system 154% cpu 7.313 total

npx rollup modified.js --file modified.rollup.js --format=cjs --silent > /dev/null
make modified.rollup.js  3.98s user 0.24s system 154% cpu 2.741 total
```
