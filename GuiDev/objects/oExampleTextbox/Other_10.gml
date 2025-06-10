/// @desc Step

// Feather disable all

event_inherited();

if (GuiPrimaryGetClick())
{
    GuiTextOpen(text, function(_text, _state)
    {
        text = _text;
    });
}