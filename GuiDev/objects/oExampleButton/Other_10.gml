/// @desc Step

event_inherited();

if (BentoPrimaryGetClick())
{
    if (is_callable(clickFunc))
    {
        clickFunc();
    }
}