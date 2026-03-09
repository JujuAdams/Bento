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
        BentoFocusClose();
    }
    
    if (BentoFocusGetTop() == self)
    {
        if ((BentoCursorGetDX() != 0) || (BentoCursorGetDY() != 0))
        {
            BentoScrollAddPos(-2*BENTO_MOUSE_WHEEL_SCROLL_SPEED*BentoCursorGetDX(),
                              -2*BENTO_MOUSE_WHEEL_SCROLL_SPEED*BentoCursorGetDY(),
                              BENTO_DEFAULT_SCROLL_SPEED);
        }
    }
    
    if (BentoCursorGetEnterByNavigation())
    {
        audio_play_sound(sndBentoExBlip, 0, false);
    }
}