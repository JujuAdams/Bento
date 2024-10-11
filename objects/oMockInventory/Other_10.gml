/// @param Step

// Feather disable all

GuiScrollOnMouse();

if (GuiNavGetButton("escape"))
{
    GuiNavButtonConsume("escape");
    GuiDestroy();
}