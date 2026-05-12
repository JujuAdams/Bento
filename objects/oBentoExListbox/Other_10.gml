// Feather disable all

/// @desc Step

if (BentoUsingNavigation())
{
    if (BentoPrimaryGetClick())
    {
        BentoFocusOpen(BENTO_FOCUS_POINTER_CANCEL_ALWAYS);
    }
    
    if (BentoHotkeyGetPress(BENTO_HOTKEY_CANCEL))
    {
        BentoInputConsume();
        BentoFocusClose();
    }
}

if (BentoCursorGetEnterByPlayer() && BentoUsingNavigation())
{
    audio_play_sound(sndBentoExBlip, 0, false);
}