// Feather disable all

if (not GuiNameExists("main menu"))
{
    GuiSetBehavior(id, GuiNavUsingPointer()? GUI_BEHAVIOR_COSMETIC : GUI_BEHAVIOR_MODAL);
}