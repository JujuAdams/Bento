// Feather disable all

event_inherited();

BentoLayoutList(BENTO_AXIS_Y, fa_center, fa_top);
BentoLayoutSetClampInside(true);
BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
BentoLayoutSetPadding(10, 10, 10, 10);
BentoLayoutSetGutter(10, 10);
BentoLayoutSetAlignSelf(fa_left, fa_top);
BentoLayoutSetMinSize(32, 32);

BentoFocusOpen(BENTO_FOCUS_POINTER_DESTROY_ON_CLICK);