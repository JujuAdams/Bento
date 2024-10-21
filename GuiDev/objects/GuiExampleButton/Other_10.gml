/// @desc Step

// Feather disable all

event_inherited();

GuiScrollOnPointer();

if (GuiNavGetClick())
{
    show_debug_message($"Clicked \"{text}\"");
    func();
}