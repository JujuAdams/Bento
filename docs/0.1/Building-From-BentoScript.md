# Building From BentoScript

&nbsp;

BentoScript is the language that Bento uses to describe UI layouts (as well as UI behaviour). BentoScript is a modified version of [Catspeak]() by [Katsaii](), a language specifically designed to work smoothly with GameMaker. BentoScript is compiled at runtime by the library and therefore can, and does, support live updating of UI layouts.

At any rate, BentoScript isn't a million miles away from GML and if you're comfortable with GML then you'll get to grips with it quickly:

- Variables are weakly typed. Variables can be numbers, strings, arrays, structs, or functions.

- There are no methods and every function is called in the current scope.

- There are only `while` loops. The other types of loops in GML (`for` `repeat` `do...until` `with`) aren't supported.

- `switch...case` statements aren't supported either.

- Functions are defined using the abbreviation `fn` (instead of GML's `function`).

- Function definitions come up a lot when defining callbacks and most callbacks don't receive arguments. If a function has no arguments then instead of typing `fn()` you can shorten it further to `fn`.

- A new keyword `build` has been added to assist with creating a UI tree (`build` is similar to Catspeak's native `use` but it returns the result of the close function).

- BentoScript doesn't support the unary operators `++` or `--` (use `+= 1` or `-= 1` respectively).