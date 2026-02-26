// Feather disable all

/// @desc Step

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

//If Bento thinks this button has been clicked then trigger the callback function
if (BentoPrimaryGetClick())
{
    if (is_callable(clickFunc))
    {
        clickFunc();
    }
}