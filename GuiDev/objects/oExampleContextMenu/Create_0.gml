// Feather disable all

event_inherited();

GuiLayoutSetList();
GuiLayoutSetClampInside(true);
GuiLayoutSetResizeType(GUI_RESIZE_SHRINK, GUI_RESIZE_SHRINK);
GuiLayoutSetPadding(10, 10, 10, 10);
GuiLayoutSetGutter(10, 10);
GuiLayoutSetListAxis(GUI_AXIS_Y);
GuiLayoutSetListAlign(fa_center, fa_top);
GuiLayoutSetAlignSelf(fa_left, fa_top);
GuiLayoutSetMinSize(32, 32);

GuiFocusOpen(GUI_FOCUS_POINTER_IGNORE);