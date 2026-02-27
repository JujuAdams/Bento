// Feather disable all

/// @desc Step

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

if (BentoUsingDirectional())
{
    if (BentoPrimaryGetClick())
    {
        BentoFocusOpen(BENTO_FOCUS_POINTER_CANCEL_ALWAYS);
    }
    
    if (BentoHotkeyGetPress(BENTO_HOTKEY_CANCEL_TEXT_INPUT))
    {
        BentoInputConsume();
        BentoFocusClose();
    }
}