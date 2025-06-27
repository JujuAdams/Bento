// Feather disable all

event_inherited();

BentoLayoutSetList(GUI_AXIS_Y, fa_center, fa_top);
BentoLayoutSetClampInside(true);
BentoLayoutSetResizeType(GUI_RESIZE_SHRINK, GUI_RESIZE_SHRINK);
BentoLayoutSetPadding(10, 10, 10, 10);
BentoLayoutSetGutter(10, 10);
BentoLayoutSetAlignSelf(fa_left, fa_top);
BentoLayoutSetMinSize(32, 32);

BentoFocusOpen(GUI_FOCUS_POINTER_IGNORE);