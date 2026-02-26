// Feather disable all

/// @desc Step

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

if (BentoPrimaryGetClick())
{
    BentoTextOpen(text, function(_text, _state)
    {
        text = _text;
        
        if (_state == BENTO_TEXT_CONFIRM)
        {
            BentoRefSet(reference, _text);
        }
        
        if ((_state != BENTO_TEXT_PENDING) && (_state != BENTO_TEXT_INACTIVE))
        {
            if (is_callable(func))
            {
                func(_text, _state);
            }
        }
    });
}