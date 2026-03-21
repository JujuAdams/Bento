// Feather disable all

/// @desc Step

// An example that demonstrates how to make a stepper for continuous quantitative values. It
// can be manipulated using pointer input or directional input. Clicking on the left or right
// sides will scroll through options. Directional input uses the x-axis movement to trigger
// scrolling through options (in this example project, that means pressing the left and right
// arrow keys).

var _delta = 0;

if (BentoUsingPointer())
{
    // Detect clicks to scroll through the option array.
    if (BentoPrimaryGetClick())
    {
        _delta = sign(BentoCursorGetX() - 0.5*(bbox_left + bbox_right));
        if (_delta == 0) _delta = 1;
    }
}
else if (BentoUsingDirectional())
{
    if (useFocus)
    {
        if (BentoPrimaryGetClick())
        {
            BentoFocusToggle(BENTO_FOCUS_POINTER_CANCEL_ALWAYS);
        }
        
        if (BentoHotkeyGetPress(BENTO_HOTKEY_CANCEL))
        {
            BentoFocusClose();
        }
    }
    
    if ((not useFocus) || (BentoFocusGetType() != BENTO_FOCUS_NONE))
    {
        // Detect directional input to scroll throught the option array.
        if (BentoCursorGetHover())
        {
            _delta = sign(BentoCursorGetDX());
        }
    }
    
    if (BentoCursorGetEnterByNavigation())
    {
        audio_play_sound(sndBentoExBlip, 0, false);
    }
}

if (_delta != 0)
{
    var _value = BentoRefGet(reference, valueMin);
    
    if (not is_numeric(_value))
    {
        _value = valueMin;
    }
    
    BentoRefSet(reference, clamp(_value + _delta*valueStep, valueMin, valueMax));
    
    if (is_callable(func))
    {
        func(_value); //Execute the callback
    }
}