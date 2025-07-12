/// @desc Step

// Feather disable all

event_inherited();

var _length = array_length(optionArray);
if (_length > 0)
{
    if (BentoUsingPointer())
    {
        // Detect clicks to scroll through the option array.
        if (BentoPrimaryGetClick())
        {
            var _delta = sign(BentoCursorGetX() - x);
            if (_delta == 0) _delta = 1;
            option = (option + _delta + _length) mod _length;
            func(option, optionArray[option]); //Execute the callback
        }
    }
    else if (BentoUsingDirectional())
    {
        // Detect directional input to scroll throught the option array.
        if (BentoCursorGetHover() && (BentoCursorGetDX() != 0))
        {
            option = (option + sign(BentoCursorGetDX()) + _length) mod _length;
            func(option, optionArray[option]); //Execute the callback
        }
    }
}