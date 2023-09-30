# Setting Up

&nbsp;

Like every library, Bento needs a bit of fitting before you can use it in your project. This page takes you through the steps required to get basic functionality and rendering up and running.

&nbsp;

### 1. Add Event Hooks

Bento requires two functions to be executed: `BentoStep()` and `BentoDraw()`.

- `BentoStep()` handles user input and updates of the internal state of UI elements and should be placed in a Step event.

- `BentoDraw()` draws the user interface and is typically placed in the Draw GUI event.

It's useful to have a specific persistent and permanent object instance set up to execute these two functions. Make sure you don't accidentally deactivate such an instance if you're using the instance deactivation feature in GameMaker.

?> There are some situations where you might want to draw your UI onto a surface and you're welcome to do so!

&nbsp;

### 2. Set The Host Dimensions

Bento defaults to using the GUI width and height for the size of the screen. This is a pretty good guess but every has their own way of working. If you're using some other UI scale, which is reasonably common amongst pixel art games, call `BentoHostLTRB()` with accurate values to ensure you're building your UI at the right scale. You should only call this function once at the start of the game.

&nbsp;

### 3. Create A BentoScript

Bento is built to work best with externally stored BentoScript files. These files contain instructions on how to lay out UI elements and what those UI elements should do. It's entirely possible to build UI with Bento using pure GML calls but BentoScript is by far the smoothest way to use Bento in your game. As a result, the next step in getting Bento up and running is creating a BentoScript file.

Here's a good starter script:

```
build BentoRectangle {
	ltrb = [0, 0, "100%", "100%"]

	fillColor   = C_RED
	fillAlpha   = 0.5
	borderAlpha = 0

	build BentoText {
		xy = ["50%", "40%"]
		label = "Welcome to Bento!"
	}

	build BentoButton {
		xywh = ["50%", "60%", "20%", "15%"]
		
		targetListen = "action"
		callbackClick = fn {
			DebugLog("Clicked the button!")
		}
	}
}
```

&nbsp;

### 4. Execute A File

The BentoScript file we just created won't do anything by itself, of course. Bento has a handy one-function call that creates a new Bento layer and executes a file, placing the created UI elements on that layer. Call `BentoFileExecuteLayerTop()` targeting the BentoScript file you created, and make sure to give the layer a distinctive name.

Once you execute `BentoFileExecuteLayerTop()`, Bento will create the UI elements described in the file you targeted. If you've targeted the above UI example, you should see a semi-transparent red rectangle fill the screen with the text "Welcome to Bento!" positioned in the middle. There's also a non-functional button, which we'll address next.

&nbsp;

### 5. Add Mouse Input

Getting user input into Bento is done with a couple functions and the two we'll be talking about here are `BentoInputPointer()` and `BentoInputButtonTarget()`.

- `BentoInputPointer()` sets the position of Bento's internal pointer.

- `BentoInputButtonTarget()` sends a physical button state into Bento, allowing the library to process that input and to react to it.

You should call these two functions _before_ `BentoStep()` (otherwise your user input will be handled one step later). For example:

```gml
BentoInputPointer(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0));
BentoInputButtonTarget("action", device_mouse_check_button(0, mb_left));
BentoStep();
```

This snippet will funnel mouse position and button state into Bento. This will activate interaction with the button we created and, when clicked, that button will spit out `Clicked the button` into the console output.