# Layouts & Methods

&nbsp;

?> You can read a full list of shared callbacks [here](Shared-Methods).

Bento's UI elements, in addition to getter / setter variables and callbacks, also have explicit methods calls that you can use. These methods vary from very useful and useful, such as `.Destroy()`, to obscure, such as `ButtonStateSet()`. Some UI templates also have methods and when customising your own UI elements you'll likely want to add your own.

Of particular note, however, are the "layout methods". These methods override the `callbackLayout` and `callbackLayoutCheck` callbacks and set up common layout behaviours. You'll find yourself using these a lot in production as a way to simplify setting up menus and inventories etc.  Here's an example:

```
build BentoBox {
	//Place the menu at the left-hand side of the screen
	ltrb = ["10%", "10%", "40%", "90%"]

	//Set up a vertical list that horizontally centres children for this menu
	LayoutAsVerticalList("center", 20)

	build BentoTextButton {
		label = "New Game"
		size = [200, 50]

		targetList = "action"
		callbackClick = fn {
			ChangePage("new game")
		}
	}

	build BentoTextButton {
		label = "Settings"
		size = [200, 50]

		targetList = "action"
		callbackClick = fn {
			ChangePage("settings")
		}
	}

	build BentoTextButton {
		label = "Quit"
		size = [200, 50]

		targetList = "action"
		callbackClick = fn {
			GameEnd()
		}
	}
}
```