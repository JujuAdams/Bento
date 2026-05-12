// Feather disable all

//Always call this in the Create event in objects that inherit from `oBentoAncestor`
event_inherited();

if (image_blend == c_white)
{
    image_blend = BENTO_EXAMPLE_YELLOW;
}

BentoLayoutList(BENTO_AXIS_Y, 0, 0);
BentoClipSetEnabled(true);
BentoScrollSetEnabled(true, true);
BentoSetButton(BENTO_BUTTON_NAVIGATION);
BentoFocusSetEnclose(BENTO_ENCLOSE_NAVIGATION)

BentoSetDrawAfter(true);