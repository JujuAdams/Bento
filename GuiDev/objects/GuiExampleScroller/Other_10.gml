/// @desc Step

// Feather disable all

event_inherited();

GuiScrollOnPointer();

var _delta = 0;

if (GuiNavUsingPointer())
{
    if (GuiNavGetClick())
    {
        _delta = sign(GuiNavGetCursorX() - x);
        if (_delta == 0) _delta = 1;
    }
}
else if (GuiNavUsingGamepad())
{
    if (GuiNavGetOver())
    {
        _delta = sign(GuiNavGetDX());
    }
}

if (_delta != 0)
{
    value = clamp(value + _delta*valueStep, valueMin, valueMax);
    func(value);
}