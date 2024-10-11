/// @desc Step

// Feather disable all

event_inherited();

GuiScrollOnMouse();

var _length = array_length(optionArray);
if (_length > 0)
{
    if (GuiNavUsingPointer())
    {
        if (GuiNavGetClick())
        {
            var _delta = sign(GuiNavGetMouseX() - x);
            if (_delta == 0) _delta = 1;
            option = (option + _delta + _length) mod _length;
            func(option, optionArray[option]);
        }
    }
    else if (GuiNavUsingGamepad())
    {
        if (GuiNavGetOver())
        {
            option = (option + sign(GuiNavGetDX()) + _length) mod _length;
            func(option, optionArray[option]);
        }
    }
}