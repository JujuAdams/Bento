// Feather disable all

event_inherited();

GuiLayoutSetList(GUI_AXIS_X, fa_left, fa_top);
GuiLayoutSetPadding(10, 10, 10, 10);
GuiLayoutSetGutter(10, 10);
GuiLayoutSetResizeType(GUI_RESIZE_STATIC, GUI_RESIZE_STATIC);

scrollbox = GuiCreateObject(oExampleScrollbox);
with(scrollbox)
{
    GuiSetVisible(false);
    GuiLayoutSetResizeType(GUI_RESIZE_GROW, GUI_RESIZE_GROW);
    GuiLayoutSetGutter(10, 10);
    GuiLayoutSetListAlign(fa_center, fa_top);
}

scrollbar = GuiCreateObject(oGuiLibScrollbarV, { target: scrollbox });
with(scrollbar)
{
    GuiLayoutSetSize(10, undefined);
}