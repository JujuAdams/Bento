// Feather disable all

event_inherited();

GuiLayoutSetList(GUI_AXIS_X, fa_left, fa_top);
GuiLayoutSetResizeType(GUI_RESIZE_STATIC, GUI_RESIZE_STATIC);

var _scrollbox = GuiCreateObject(oExampleScrollbox);
with(_scrollbox)
{
    GuiSetVisible(false);
    GuiLayoutSetResizeType(GUI_RESIZE_GROW, GUI_RESIZE_GROW);
    GuiLayoutSetGutter(10, 10);
    GuiLayoutSetListAlign(fa_center, fa_top);
}

with(GuiCreateObject(oGuiLibScrollbarV, { target: _scrollbox }))
{
    GuiLayoutSetSize(10, undefined);
}

GuiSetContainer(_scrollbox);