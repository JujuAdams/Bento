// Feather disable all

/// @desc Step

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

if (BentoPrimaryGetClick())
{
    __displayText = BentoRefGet(reference, "");
    
    BentoTextOpen(__displayText, function(_text, _state)
    {
        __displayText = _text;
        
        if (_state == BENTO_TEXT_CONFIRM)
        {
            BentoRefSet(reference, _text);
        }
        else if ((_state == BENTO_TEXT_ABORT) || (_state == BENTO_TEXT_ERROR))
        {
            __displayText = BentoRefGet(reference, "");
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