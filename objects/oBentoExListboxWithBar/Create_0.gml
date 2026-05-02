// Feather disable all

//Always call this in the Create event in objects that inherit from `oBentoAncestor`!
event_inherited();

BentoLayoutList(BENTO_AXIS_Y, 0, 0);
BentoClipSetEnabled(true);
BentoScrollSetEnabled(true, true);
BentoSetButton(BENTO_BUTTON_DIRECTIONAL);
BentoFocusSetEnclose(BENTO_ENCLOSE_DIRECTIONAL);

BentoScrollbarSetVert(false, 40, 10, 10, 10, 10, false);
BentoSetDrawAfter(true);