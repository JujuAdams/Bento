// Feather disable all

event_inherited();

BentoLayoutSetList(GUI_AXIS_Y, fa_left, fa_top);
BentoClipSetEnabled(true);
BentoScrollSetEnabled(true, true);
BentoSetButton(GUI_BUTTON_DIRECTIONAL);
BentoFocusSetEnclose(GUI_ENCLOSE_DIRECTIONAL);

BentoScrollbarSetVert(false, 20, 0, 10, 10, 10, false);
BentoSetDrawAfter(true);