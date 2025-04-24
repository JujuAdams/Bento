/// @desc Step

event_inherited();

GuiScrollOnPointer();

if (GuiNavGetClick())
{
    show_debug_message($"{id} = {GuiNameGet()}");
}