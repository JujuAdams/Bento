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
        BentoScrollMove(-30*BentoCursorGetDX(), -30*BentoCursorGetDY());
    }
}