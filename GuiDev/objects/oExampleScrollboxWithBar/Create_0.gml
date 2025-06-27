// Feather disable all

event_inherited();

BentoLayoutSetList(BENTO_AXIS_Y, fa_left, fa_top);
BentoClipSetEnabled(true);
BentoScrollSetEnabled(true, true);
BentoSetButton(BENTO_BUTTON_DIRECTIONAL);
BentoFocusSetEnclose(BENTO_ENCLOSE_DIRECTIONAL);

BentoScrollbarSetVert(false, 20, 0, 10, 10, 10, false);
BentoSetDrawAfter(true);