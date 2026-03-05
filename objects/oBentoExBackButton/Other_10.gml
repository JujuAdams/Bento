// Feather disable all

/// @desc Step

//If Bento thinks this button has been clicked then trigger the callback function
if (BentoPrimaryGetClick() || (BentoGetHoverable() && BentoHotkeyGetPress(BENTO_HOTKEY_CANCEL)))
{
    if (is_callable(func))
    {
        func();
    }
}