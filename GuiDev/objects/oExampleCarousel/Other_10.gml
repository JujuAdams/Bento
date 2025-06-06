/// @desc Step

// Feather disable all

event_inherited();

// Magic function to pass pointer context to the nearest scrollable instance up the Gui inheritance
// stack. This is crucial for creating click-and-drag scrolling.
GuiScrollOnPointer();

var _length = array_length(optionArray);
if (_length > 0)
{
    if (GuiUsingPointer())
    {
        // Detect clicks to scroll through the option array.
        if (GuiPrimaryGetClick())
        {
            var _delta = sign(GuiCursorGetX() - x);
            if (_delta == 0) _delta = 1;
            option = (option + _delta + _length) mod _length;
            func(option, optionArray[option]); //Execute the callback
        }
    }
    else if (GuiUsingDirectional())
    {
        // Detect directional input to scroll throught the option array.
        if (GuiCursorGetHover() && (GuiCursorGetDX() != 0))
        {
            option = (option + sign(GuiCursorGetDX()) + _length) mod _length;
            func(option, optionArray[option]); //Execute the callback
        }
    }
}