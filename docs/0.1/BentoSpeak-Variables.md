# Variables

?> You can read a full list of shared variables [here](Shared-Variables). Each UI template also has its own set of special variables specific to that template so make sure to read the documentation thoroughly to understand what's available.

There are many, many variables that you can read and adjust for a UI element. Variables in BentoScript behave similarly to GML. They're weakly typed to begin with, and variables types can be one of the following: boolean, number, string, array, struct, functions, or undefined. You can create local variables with `var` and variables without a prefix (e.g. `x` as opposed to `topChild.x`) are presumed to be variables available in the current scope.

BentoScript adds an extra feature on top of standard GML variables, however, and that's getter and setter functions for variables. Normally when you get and set a variable in GML you're just reading and writing variables. There's nothing else that happens. In building out Bento, however, I found that it's really useful to execute implicit behaviours when setting variables.

As an example, let's look at `ltrb`. This is a shorthand for "left, top, right, bottom" and, as you might have guessed, this variable sets the bounding box for a UI element based on a 4-element array. Internally, there is no `ltrb` variable. It's a trick! In reality, the `ltrb` variable has special getter and setter functions set up. When you set the `ltrb`variable, the four components of the array are unpacked into separate left, top, right, and bottom variables. When you get the `ltrb` variable, these four components are recombined into an array.

In fact, the majority of variables that you'll use with BentoScript are implemented as getter / setter functions. When building custom UI templates for yourself you'll likely want to be able to define your own getter / setter functions too. You can call the `VariableBind()` method to set up getter / setter functions for yourself.

!> When writing GML code to interface with Bento, it is strongly recommended that you use the `Get()` and `Set()` methods for reading and writing variables. Getter / Setter functions will only work in GML if you use these two methods!

&nbsp;

## Percentages

You'll see in a few places the use of strings that contain a percentage value. Percentage values aren't available for use everywhere, but you'll find them useful when defining the position and size of UI elements. When a percentage value is used, the resulting value passed into Bento is a fraction of the parent's width or height (as is appropriate). For example:

```
build BentoSprite {
	//Stretch the blood splatter sprite over this UI element
	sprite = sprBloodSplatter
	stretch = true

	//Position the sprite towards the upper-centre of the parent
	xy = ["50%", "30%"]

	//Cover most of the width, but less of the height, of the parent
	size = ["90%", "50%"]
}
```

Percentage values are very useful when designing responsive layouts and you'll get a lot of mileage out of them on mobile device especially.