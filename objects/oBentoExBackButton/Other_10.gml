// Feather disable all

/// @desc Step

//If Bento thinks this button has been clicked then trigger the callback function
if (BentoPrimaryGetClick() || (BentoGetHoverable() && BentoHotkeyGetPress(BENTO_HOTKEY_CANCEL)))
{
    audio_play_sound(sndBentoExBeep, 0, false);
    
    if (is_callable(func))
    {
        func();
    }
}