// Feather disable all

event_inherited();

if (GuiNavGetButton("escape"))
{
    GuiNavButtonConsume("escape");
    GuiDestroy();
}