// Feather disable all

/// @desc Step

if (BentoUsingDirectional())
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

if (BentoCursorGetEnterByNavigation() && BentoUsingDirectional())
{
    audio_play_sound(sndBentoExBlip, 0, false);
}