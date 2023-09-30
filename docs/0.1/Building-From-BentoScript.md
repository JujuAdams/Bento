# Building From BentoScript

&nbsp;

BentoScript is the language that Bento uses to describe UI layouts (as well as UI behaviour). BentoScript is a modified version of [Catspeak]() by [Katsaii](), a language specifically designed to work smoothly with GameMaker. BentoScript is compiled at runtime by the library and therefore can, and does, support live updating of UI layouts.

&nbsp;

### BentoScript Overview

BentoScript isn't a million miles away from GML and if you're comfortable with GML then you'll get to grips with it quickly:

- BentoScript is sandboxed. To access anything in your project (functions, objects, sprites, sounds, etc.) you'll need to explicitly whitelist it.

- Variables are weakly typed. Variables can be numbers, strings, arrays, structs, or functions. Struct/array literals are supported.

- There are no methods, only simple functions. Every function is called in the current scope.

- There are only `while` loops. The other types of loops in GML (`for` `repeat` `do...until` `with`) aren't supported.

- `switch...case` statements aren't supported either.

- Functions are defined using the abbreviation `fn` (instead of GML's `function`).

- Function definitions come up a lot when defining callbacks and most callbacks don't receive arguments. If a function has no arguments then instead of typing `fn()` you can shorten it further to `fn`.

- A new keyword `build` has been added to assist with creating a UI tree (`build` replaces Catspeak's native `use`, though it returns the result of the close function).

- BentoScript doesn't support the unary operators `++` or `--` (use `+= 1` or `-= 1` respectively).

&nbsp;

## Structure

```
build BentoRectangle {
	ltrb = [20, 20, parent.width-20, parent.height-20]
}
```