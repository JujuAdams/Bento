/// @desc Step

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

if (BentoPrimaryGetClick())
{
    BentoRefSet(reference, option);
    
    if (is_callable(func))
    {
        func(option);
    }
}