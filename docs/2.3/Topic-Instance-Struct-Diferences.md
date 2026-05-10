# Instance & Struct Differences

&nbsp;

Bento elements are the building blocks that your user interface is made from. Elements can be either [object instances](https://manual.gamemaker.io/beta/en/Quick_Start_Guide/Objects_And_Instances.htm) or [structs](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Overview/Structs.htm). By and large I expect Bento developers will prefer to use object instances because that's what GameMaker developers are used to. However, structs have advantages and are likely to be more useful for large, long-term projects. This article will explain the differences between instances and structs to aid in converting from one methodology to the other.

&nbsp;

## Creating Elements

!> Regardless of how you create Bento elements, as either instances or structs, you must always use `BentoDestroy()` to dispose of them.

`BentoCreate()` should be used to create object instances. `BentoCreate()` creates an instance of an object and then sets it up for use with Bento. For example:

```gml
element = BentoCreate(oBentoExText,
	                  { text: "Hello World!", font: fntBentoExCandyBeans },
	                  BentoLayerGetRoot());
```

The parameters for this function call are doing three things: setting `oBentoExText` as the object to create an instance of, setting some variables on the instance prior to the Create event for the instance being run, and setting `BentoLayerGetRoot()` as the Bento element to use as the parent for the new instance of `oBentoExText`. Please note that all objects that are going to be used with Bento should inherit from `oBentoAncestor`.

Structs on the other hand do not use `BentoCreate()`. Structs should instead be "newed" using a constructor:

```gml
element = new BentoExConstrText("Hello World!", fntBentoExCandyBeans, BentoLayerGetRoot());
```

This function call is doing roughly the same thing as `BentoCreate()` above. We're choosing a constructor use, we're passing in some variables, and then we're setting the parent to use for the new struct. The constructor looks like this:

```gml
/// @param text
/// @param font
/// @param [parent=self]

function BentoExConstrText(_text, _font, _parent = other) : BentoConstrAncestor(_parent) constructor
{
	text = _text;
	font = _font;

	// ...
}
```

!> For a constructor to work with Bento it must inherit from `BentoConstrAncestor()` and it must pass a parent as the one parameter to `BentoConstrAncestor()`.

Here we're grabbing two parameters (`_text` and `_font`) and then passing them directly to two struct variables. The `_parent` parameter is a little unusual. We're passing this parameter into the inherited `BentoConstrAncestor` constructor but also we have a default value that is `other`. At first glance, this appears to conflict with the stated default value in the `@param` definition. What's happening here is that the default value for a constructor parameter is set after GameMaker internally moves into the scope of the new struct. This means that `other` refers to the scope outside of the new struct which is the "self" that the constructor was called in.

Basically this is what's happening:

```gml
with(mainMenu)
{
    var _mainMenu = self;

	with(aNewStruct)
	{
		var _alsoMainMenu = other;
	}
}
```

Because we want the parent for the new struct to the thing that created it, that means we set the default value for `_parent` to be `other`.

&nbsp;

## `image_alpha`

For compatibility with Bento's native animation system, structs that inherit from `BentoConstrAncestor` have `image_alpha` set on them. This is initialised to `1` much like a standard GameMaker object index. You are welcome to set and get this variable as you would with an object instance.

&nbsp;

## User Events vs. Callbacks

Bento instances use a system of user events to execute behaviours when necessary. These user events are executed downstream of `BentoSystemUpdate()` and `BentoSystemDraw()`. You can read more about user events [here](Topic-User-Events).

IStructs don't have user events in GML. Instead, Bento has a special callback method for each user event. These callback methods are set by `BentoConstrAncestor()` when constructing the struct. There is one callback per user event and they have a one-to-one equivalence. Their behaviour is identical.

| User Event | Method              | Behaviour                                                                                                                                      | Usage                                                                                       |
|------------|---------------------|------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| `0`        | `.eventStep`        | Called if necessary but often omitted                                                                                                          | Bento logic, such as checks against `BentoPrimaryGetClick()`, should go in here             |
| `1`        | `.eventDraw`        | Before applying GPU scissoring for the element (if applicable) and before drawing children                                                     | The "main" draw event for elements                                                          |
| `2`        | `.eventDrawAfter`   | After drawing children and after resetting GPU scissoring                                                                                      | Useful for drawing graphics over child elements such as an attractive border                |
| `3`        | `.eventDrawHover`   | Only called when an element is hovered. Called after all sibling children but before resetting GPU scissoring for a layout ancestor            | Drawing highlights on and around hovered elements, especially when in directional mode      |
| `4`        | `.eventDrawDragged` | Only called when an element is being dragged in the drag-and-drop system and at the very end of the draw loop after all other elements         | Drawing a drag-and-drop item above all other elements                                       |
| `5`        | `.eventReposition`  | Called whenever an element's layout position or layout size changes. This event will also be called when a drag-and-drop item is being dragged | Resetting properties (such as `image_xscale`) that rely on the size and shape of an element |

?> You should **not** definte callback methods as `static`. The callback methods should be scoped to the struct and set as normal variables.

Exactly how you use these callbacks is up to you. Here's an example of a text button that shows a common basic use:

```gml
/// Example of a struct-based button.
/// 
/// @param [text]
/// @param [clickFunc]
/// @param [parent=self]

function BentoExConstrButton(_text = "", _clickFunc = undefined, _parent = other) : BentoConstrAncestor(_parent) constructor
{
    //Allow ourselves to be hovered and clicked in any input mode
    BentoSetButton(BENTO_BUTTON_ALWAYS);

    if (_clickFunc == undefined)
    {
    	//Set the click function to a basic default behaviour
        _clickFunc = function()
        {
            show_debug_message($"Button {string_delete(string(ptr(self)), 1, 8)} clicked");
        }
    }
    else
    {
	    //Ensure the click function is scoped to this instance
	    func = method(self, _clickFunc);
	}

	//Set our text to draw
    text = _text;

    if (text != "")
    {
    	//If we have some valid text then force the size of the element
        BentoLayoutSetSize(string_width(text) + 20, string_height(text) + 20);
    }
    else
    {
		//Otherwise choose a default size if there's no text
		BentoLayoutSetSize(32, 32);
    }
    
    
    
    
    //Called when Bento needs to update the logic state of the button
    eventStep = function()
    {
        if (BentoPrimaryGetClick())
        {
            if (is_callable(func))
            {
                func();
            }
        }
    }
    
    //Called when Bento need to draw the button
    eventDraw = function()
    {
    	//Draw the button background
    	draw_set_color(c_dkgray);
    	draw_rectangle(bentoLeft, bentoTop, bentoRight, bentoBottom, false);
        
        //Draw text in the centre of the button
        if (text != "")
        {
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_set_alpha(c_ltgray);
            draw_text(0.5*(bentoLeft + bentoRight), 0.5*(bentoTop + bentoBottom), text);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_set_alpha(1);
        }

        //Reset the draw colour
        draw_set_alpha(c_white);
        
        //Draw a highlight over the button if the element is being hovered
        if (BentoCursorGetHover())
        {
	    	draw_set_alpha(0.5);
	    	draw_rectangle(bentoLeft, bentoTop, bentoRight, bentoBottom, false);
	    	draw_set_alpha(1);
        }
    }
}
```