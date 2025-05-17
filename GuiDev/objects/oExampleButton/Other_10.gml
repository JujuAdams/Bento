/// @desc Step

event_inherited();

GuiScrollOnPointer();

if (GuiPrimaryGetClick())
{
    if (is_callable(clickFunc))
    {
        clickFunc();
    }
}