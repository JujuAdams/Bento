// Feather disable all

/// @desc Step

if (BentoUsingDirectional())
{
    if (BentoPrimaryGetClick())
    {
        audio_play_sound(sndBentoExBeep, 0, false);
        
        BentoFocusOpen(BENTO_FOCUS_POINTER_CANCEL_ALWAYS);
    }
    
    if (BentoHotkeyGetPress(BENTO_HOTKEY_CANCEL))
    {
        audio_play_sound(sndBentoExBeep, 0, false);
        
        BentoInputConsume();
        BentoFocusClose();
    }
}

if (BentoCursorGetEnterByNavigation() && BentoUsingDirectional())
{
    audio_play_sound(sndBentoExBlip, 0, false);
}