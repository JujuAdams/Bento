/// @desc Step

// Feather disable all

// An example that demonstrates how to make a scroller for continuous quantitative values. It
// can be manipulated using pointer input or directional input. Clicking on the left or right
// sides will scroll through options. Directional input uses the x-axis movement to trigger
// scrolling through options (in this example project, that means pressing the left and right
// arrow keys).

event_inherited();

var _delta = 0;

if (BentoUsingPointer())
{
    // Detect clicks to scroll through the option array.
    if (BentoPrimaryGetClick())
    {
        _delta = sign(BentoCursorGetX() - x);
        if (_delta == 0) _delta = 1;
    }
}
else if (BentoUsingDirectional())
{
    // Detect directional input to scroll throught the option array.
    if (BentoCursorGetHover())
    {
        _delta = sign(BentoCursorGetDX());
    }
}

if (_delta != 0)
{
    value = clamp(value + _delta*valueStep, valueMin, valueMax);
    func(value); //Execute the callback
}