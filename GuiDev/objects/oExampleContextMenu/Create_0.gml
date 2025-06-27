// Feather disable all

event_inherited();

BentoLayoutSetList(BENTO_AXIS_Y, fa_center, fa_top);
BentoLayoutSetClampInside(true);
BentoLayoutSetResizeType(BENTO_RESIZE_SHRINK, BENTO_RESIZE_SHRINK);
BentoLayoutSetPadding(10, 10, 10, 10);
BentoLayoutSetGutter(10, 10);
BentoLayoutSetAlignSelf(fa_left, fa_top);
BentoLayoutSetMinSize(32, 32);

BentoFocusOpen(BENTO_FOCUS_POINTER_IGNORE);