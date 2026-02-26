// Feather disable all

/// @desc Step

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

if (BentoPrimaryGetClick())
{
    BentoTextOpen(text, function(_text, _state)
    {
        text = _text;
    });
}