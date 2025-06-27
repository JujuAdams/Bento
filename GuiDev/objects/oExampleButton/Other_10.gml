/// @desc Step

event_inherited();

BentoScrollOnPointer();

if (BentoPrimaryGetClick())
{
    if (is_callable(clickFunc))
    {
        clickFunc();
    }
}