// Feather disable all

event_inherited();

GuiLayoutSetList(GUI_AXIS_Y, fa_center, fa_top);
GuiLayoutSetClampInside(true);
GuiLayoutSetResizeType(GUI_RESIZE_SHRINK, GUI_RESIZE_SHRINK);
GuiLayoutSetPadding(10, 10, 10, 10);
GuiLayoutSetGutter(10, 10);
GuiLayoutSetAlignSelf(fa_left, fa_top);
GuiLayoutSetMinSize(32, 32);

GuiFocusOpen(GUI_FOCUS_POINTER_IGNORE);