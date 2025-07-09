/// @desc Step

// Feather disable all

event_inherited();

if (BentoPrimaryGetClick())
{
    BentoTextOpen(text, function(_text, _state)
    {
        text = _text;
    });
}

if (BentoTextGetTargeted())
{
    if (BentoHotkeyGetPress(BENTO_HOTKEY_CANCEL))
    {
        BentoInputConsume();
        BentoTextClose();
    }
}