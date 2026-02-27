// Feather disable all

/// @desc Step

var _funcGetOptionIndex = function()
{
    var _option = BentoRefGet(reference, undefined);
    var _optionIndex = array_get_index(optionArray, _option);
    return max(_optionIndex, 0);
}

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
            
            var _optionIndex = (_funcGetOptionIndex() + _delta + _length) mod _length;
            
            var _option = optionArray[_optionIndex];
            BentoRefSet(reference, _option);
            func(_option); //Execute the callback
        }
    }
    else if (BentoUsingDirectional())
    {
        // Detect directional input to scroll throught the option array.
        if (BentoCursorGetHover() && (BentoCursorGetDX() != 0))
        {
            var _optionIndex = (_funcGetOptionIndex() + sign(BentoCursorGetDX()) + _length) mod _length;
            
            var _option = optionArray[_optionIndex];
            BentoRefSet(reference, _option);
            func(_option); //Execute the callback
        }
    }
}