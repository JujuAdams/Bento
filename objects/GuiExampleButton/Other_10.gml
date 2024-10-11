/// @desc Step

// Feather disable all

event_inherited();

GuiScrollOnMouse();

if (GuiNavGetClick())
{
    show_debug_message($"Clicked \"{text}\"");
    func();
}