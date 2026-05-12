// Feather disable all

/// @desc Step

if (BentoUsingNavigation())
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

if (BentoCursorGetEnterByPlayer() && BentoUsingNavigation())
{
    audio_play_sound(sndBentoExBlip, 0, false);
}