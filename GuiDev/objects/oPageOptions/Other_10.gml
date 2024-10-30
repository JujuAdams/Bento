/// @desc Step

// Feather disable all

GuiScrollOnPointer();

if (GuiButtonGetPress("escape"))
{
    GuiNavConsume();
    GuiDestroy();
}