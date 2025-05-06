// Feather disable all

event_inherited();

GuiFocusOpen(GUI_FOCUS_POINTER_IGNORE);

GuiLayoutSetClampInside(true);
GuiLayoutSetResizeType(GUI_RESIZE_FIT, GUI_RESIZE_FIT);
GuiLayoutSetPadding(10, 10, 10, 10);
GuiLayoutSetGutter(10, 10);
GuiLayoutSetListAxis(GUI_AXIS_Y);
GuiLayoutSetListAlign(fa_center, fa_top);
GuiLayoutSetAlignSelf(fa_left, fa_top);
GuiLayoutSetMinSize(32, 32);