// Feather disable all

//Always call this in the Create event in objects that inherit from `oBentoAncestor`!
event_inherited();

BentoVarEnsureMany(
    "text",  "",
    "frame", true,
);

BentoLayoutList(BENTO_AXIS_Y, 0, 0);
BentoClipSetEnabled(true);
BentoScrollSetEnabled(false, true);
BentoSetButton(BENTO_BUTTON_DIRECTIONAL);
BentoFocusSetEnclose(BENTO_ENCLOSE_DIRECTIONAL);

if (frame)
{
    BentoLayoutSetPaddingExt(10, 10, 10, 10);
}

BentoScrollbarSetVert(false, 40, 0, 10, 10, 10, false);
BentoSetDrawAfter(true);

if (image_blend == c_white)
{
    image_blend = BENTO_EXAMPLE_YELLOW;
}

BentoCreate(oBentoExText, { text: text });