// Feather disable all

/// @desc Step

var _length = array_length(stringArray);
if (_length > 0)
{
    var _delta = 0;
    
    if (BentoUsingPointer())
    {
        // Detect clicks to scroll through the option array.
        if (BentoPrimaryGetClick())
        {
            _delta = sign(BentoCursorGetX() - 0.5*(bentoLeft + bentoRight));
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
        var _option = BentoRefGet(reference, undefined);
        var _optionIndex = max(array_get_index(stringArray, _option), 0);
        _optionIndex = (_optionIndex + _delta + _length) mod _length;
    
        var _option = stringArray[_optionIndex];
        BentoRefSet(reference, _option);
        func(_option); //Execute the callback
    }
}