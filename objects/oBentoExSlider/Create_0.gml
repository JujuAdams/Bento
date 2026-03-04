// Feather disable all

//Always call this in the Create event in objects that inherit from `oBentoAncestor`
event_inherited();

BentoSetButton(BENTO_BUTTON_ALWAYS);

BentoSetRaycastEnable(false, true);

BentoVarEnsureMany(
    "reference",      undefined,
    "valueMin",       0,
    "valueMax",       10,
    "valueStep",      1,
    "handleWidthMin", 0,
    "clickToSet",     true,
    "useFocus",       true,
    "func",           function() {}
);

if (image_blend == c_white)
{
    image_blend = BENTO_EXAMPLE_YELLOW;
}

BentoLayoutSetMinSize(undefined, 80);

//Ensure the click function is scoped to this instance
func = method(self, func);

handleHover = false;
handleHold  = false;