// Feather disable all

event_inherited();

if (GuiButtonGetPress("escape"))
{
    GuiNavConsume();
    GuiDestroy();
}