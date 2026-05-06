# "Input" Library Integration

?> You should read up on Bento's [input system in general](Topic-Input) before reading this article.

&nbsp;

["Input"](https://codeberg.org/offalynne/Input) is a popular cross-platform input library. Bento's API is intended primarily to support the general purpose use case where developers are handling various input devices themselves. However, Bento can also be integrated with "Input" to make things smoother.

Before proceeding, there are a few things to note:

1. This article presumes you are reasonably familiar with how Input works.
2. This guide is restricted to single player games. Bento and Input can be used together for multiplayer games but that falls out of scope for this guide.
3. `INPUT_KBM` combines mouse and keyboard input. Bento separates mouse and keyboard input into `BENTO_MODE_MOUSE` and `BENTO_MODE_KEYBOARD`. You will need to decide which Bento input mode `INPUT_KBM` maps to depending what kind of game you're making. `BENTO_MODE_KEYBOARD` is suitable for games that are entirely keyboard-driven and do not make use of the mouse at all.
4. I'm assuming you're making your Bento user interface into "GUI space" i.e. you're drawing the GUI in a Draw GUI event.

With that in mind, let's proceed.

&nbsp;

## Set up Input verbs

Input works using a "verb" paradigm. We'll be funnelling output values from those verbs (and a cluster) into Bento. The first step is to set up the necessary components so we have something to read.

Below is a suggested list of verbs and cluster to add to `__InputConfigVerb`. We're adding UI-specific "accept" and "cancel" verbs. We map `INPUT_VERB.UI_ACCEPT` to `gp_face1` on gamepads (`gp_face2` on Switch) and mapping `INPUT_VERB.UI_ACCEPT` to `gp_face2` on gamepads (`gp_face1` on Switch). This is a standard "A to accept, B to cancel" layout.

We also map `INPUT_VERB.UI_CANCEL` to `vk_escape` when using a mouse and/or keyboard. We can still use keyboard hotkeys even if we're using `BENTO_MODE_MOUSE` such that the mouse is the primary input device. `INPUT_VERB.UI_ACCEPT` is mapped to `vk_space`. However, this is only revelant if you've decided `INPUT_KBM` maps to `BENTO_MODE_KEYBOARD`.

Finally, we define a cluster. This cluster presumes you're using standard Input directional verbs. If not, you'll need to make the necessary adjustments to the verb names.

```gml
/// __InputConfigVerb

function __InputConfigVerb()
{
	enum INPUT_VERB
	{
	    // etc ...

	    UI_ACCEPT,
	    UI_CANCEL
	}

	enum INPUT_CLUSTER
	{
	    // etc ...

	    UI_NAVIGATION
	}

	InputDefineVerb(INPUT_VERB.UI_ACCEPT, "ui_accept", vk_space,  INPUT_ON_SWITCH? gp_face2 : gp_face1);
	InputDefineVerb(INPUT_VERB.UI_CANCEL, "ui_cancel", vk_escape, INPUT_ON_SWITCH? gp_face1 : gp_face2);

	InputDefineVerb(INPUT_CLUSTER.UI_NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);

	// etc ...
}
```

&nbsp;

## Funnel Input verbs to Bento

We'll now write some code to transfer verb state from Input to Bento. The first step is setting the input mode depending on the player's device, being careful to set the correct input mode if the player is using the `INPUT_KBM` device. Then we set primary input state in Bento based on what input mode is currently set. Instead of accessing device state directly, we go through Input to take advantage of that library's features. Next, we grab verb values from Input and set Bento hotkey state from that verb value. Note that we use `InputCheck()`. Finally, we call `BentoSystemStep()` to update the library.

```gml
/// Step event

//1. Set Bento input mode from the player's device
if (_device == INPUT_KBM)
{
	BentoSetMode(BENTO_MODE_MOUSE); //Or `BENTO_MODE_KEYBOARD`
}
else if (_device == INPUT_TOUCH)
{
	BentoSetMode(BENTO_MODE_TOUCH);
}
else if (InputDeviceIsGamepad(_device))
{
	BentoSetMode(BENTO_MODE_GAMEPAD);
}
else
{
	//Player does not have a supported device
}

//2. Funnel primary input into Bento
if (BentoUsingPointer())
{
    BentoInputPointer(InputMouseGuiX(), InputMouseGuiY(), InputMouseCheck());
}
else
{
	BentoInputDirectional(InputX(INPUT_CLUSTER.UI_NAVIGATION), InputY(INPUT_CLUSTER.UI_NAVIGATION), InputCheck(INPUT_VERB.UI_ACCEPT);
}

//3. Set hotkeys based on further verb state
BentoInputHotkey(BENTO_HOTKEY_CANCEL, InputCheck(INPUT_VERB.UI_CANCEL));

//4. Finally, update Bento
BentoSystemStep(0, 0, display_get_gui_width(), display_get_gui_height());
```

&nbsp;

## Considerations

Input has a function called `InputVerbConsume()` that will prevent further checks against a verb from returning `true` until the verb is released and then pressed again. Bento's input tracking is a wholly different system so `InputVerbConsume()` will not directly interact with Bento's input handling. Instead, you should use `BentoInputConsume()` to replicate this behaviour.