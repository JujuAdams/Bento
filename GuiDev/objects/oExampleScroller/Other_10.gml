/// @desc Step

// Feather disable all

// Juju: An example that demonstrates how to make a scroller for continuous quantitative values. It
//       can be manipulated using pointer input or directional input. Clicking on the left or right
//       sides will scroll through options. Directional input uses the x-axis movement to trigger
//       scrolling through options (in this example project, that means pressing the left and right
//       arrow keys).

event_inherited();

// Magic function to pass pointer context to the nearest scrollable instance up the Gui inheritance
// stack. This is crucial for creating click-and-drag scrolling.
GuiScrollOnPointer();

var _delta = 0;

if (GuiNavUsingPointer())
{
    // Detect clicks to scroll through the option array.
    if (GuiNavGetClick())
    {
        _delta = sign(GuiNavGetCursorX() - x);
        if (_delta == 0) _delta = 1;
    }
}
else if (GuiNavUsingDirectional())
{
    // Detect directional input to scroll throught the option array.
    if (GuiNavGetOver())
    {
        _delta = sign(GuiNavGetDX());
    }
}

if (_delta != 0)
{
    value = clamp(value + _delta*valueStep, valueMin, valueMax);
    func(value); //Execute the callback
}