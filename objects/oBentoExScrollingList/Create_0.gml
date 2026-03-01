// Feather disable all

//Always call this in the Create event in objects that inherit from `oBentoAncestor`
event_inherited();

BentoLayoutList(BENTO_AXIS_Y, 0, 0);
BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
BentoClipSetEnabled(true);
BentoScrollSetEnabled(true, true);

BentoSetDrawAfter(true);

if (image_blend == c_white)
{
    image_blend = BENTO_EXAMPLE_YELLOW;
}