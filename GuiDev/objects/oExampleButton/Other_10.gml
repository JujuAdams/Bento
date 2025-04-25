/// @desc Step

event_inherited();

GuiScrollOnPointer();

if (GuiNavGetClick())
{
    if (is_callable(clickFunc))
    {
        clickFunc();
    }
}