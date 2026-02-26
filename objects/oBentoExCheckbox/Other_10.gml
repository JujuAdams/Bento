// Feather disable all

/// @desc Step

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

if (BentoPrimaryGetClick())
{
    var _value = BentoRefToggle(reference);
    
    if (is_callable(func))
    {
        func(_value);
    }
}