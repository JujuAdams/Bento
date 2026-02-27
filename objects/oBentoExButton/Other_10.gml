// Feather disable all

/// @desc Step

//If Bento thinks this button has been clicked then trigger the callback function
if (BentoPrimaryGetClick())
{
    if (is_callable(func))
    {
        func();
    }
}