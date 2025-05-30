// Feather disable all

event_inherited();

GuiLayoutSetList();
GuiLayoutSetListAxis(GUI_AXIS_X);
GuiLayoutSetResizeType(GUI_RESIZE_STATIC, GUI_RESIZE_STATIC);

var _scrollbox = GuiCreateObject(oExampleScrollbox);
with(_scrollbox)
{
    GuiSetVisible(false);
    GuiLayoutSetResizeType(GUI_RESIZE_GROW, GUI_RESIZE_GROW);
    GuiLayoutSetGutter(10, 10);
    GuiLayoutSetListAlign(fa_center);
}

with(GuiCreateObject(oGuiLibScrollbarV, { target: _scrollbox }))
{
    GuiLayoutSetSize(10, undefined);
}

GuiSetContainer(_scrollbox);