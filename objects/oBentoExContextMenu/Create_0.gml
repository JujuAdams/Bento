// Feather disable all

event_inherited();

BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
BentoLayoutSetClampInside(true);
BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
BentoLayoutSetPadding(10, 10, 10, 10);
BentoLayoutSetGutter(10, 10);
BentoLayoutSetAnchor(0, 0);
BentoLayoutSetMinSize(32, 32);

BentoFocusOpen(BENTO_FOCUS_POINTER_DESTROY_ON_CLICK);