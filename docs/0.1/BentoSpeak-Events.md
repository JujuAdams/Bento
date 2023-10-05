# Events

&nbsp;

?> You can read a full list of shared events [here](Shared-Events), and there's a quick reference cheat sheet [here](Event-Cheatsheet).

Events are the way Bento passes control to your game when an event happens. This includes straight-forward situations where the player clicks on a button; in this situation, the "Click" event is executed. You'll naturally want to define what should happen when the player clicks a button individually per button. This is where the special variable `eventClick` comes in. Here's an example:

```
build BentoButton {
	//Centre the button in the parent
	xy = ["50%", "50%"]

	//Give us a big enough size to click
	size = [200, 100]

	//Listen for the left mouse button
	targetListen = "action"

	//Define an event for clicking the button
	callbackClick = fn {
		//When clicked, show a message in the debug log
		DebugLog("Ping!")
	}
}
```

The important point to note here is that we define the event by setting it to a function that we define using the `fn { ... }` syntax. Events must always be defined as functions so that Bento has something to execute when the event occurs.

Some events receive an argument, and the "Click" event is actually one of those events. If you want your event to be able to receive an argument (or many arguments) then you can add some brackets to the function definition, as you normally would in GML, to grab those arguments e.g.:

```
build BentoButton {
	//Centre the button in the parent
	xy = ["50%", "50%"]

	//Give us a big enough size to click
	size = [200, 100]

	//Listen for the left mouse button
	targetListen = ["action", "alt"]

	//Define an event for clicking the button
	eventClick = fn(buttonName) {
		DebugLog("You pressed \"" + String(buttonName) + "\"")
	}
}
```

&nbsp;

## Inheritance

Events have a further property: you can execute the event for the event from a parent template (constructor). This is done by calling `CallInherited()` or `Super()` in BentoScript, or calling `BentoCallInherited()` in GML. This is especially useful when you want to extend the behaviour of a UI template without overriding the behaviour of that UI template entirely. For example, let's we wanted to play a sound effect when a particular button is highlighted:

```
build BentoButton {
	//Centre the button in the parent
	xy = ["50%", "50%"]

	//Give us a big enough size to click
	size = [200, 100]

	//Listen for the left mouse button
	targetListen = "action"

	//Define an event for highlighting the button
	eventEnter = fn(buttonName) {
		//Make sure we call the inherited behaviour
		CallInherited()

		//Play the sound
		AudioPlay(sndSquelch)
	}
}
```