// Feather disable all

//Always call this in the Create event in objects that inherit from `oBentoAncestor`
event_inherited();

BentoSetButton(BENTO_BUTTON_ALWAYS);
BentoFocusSetEnclose(BENTO_ENCLOSE_NAVIGATION);

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

if (not useFocus)
{
    // Disables raycasting in particular axes. This only applies to navigation input where raycasting
    // is used to work out which element to jump to when pushing in a particular direction. This does
    // not apply to navigation links created with `BentoLink*()` functions. We disable horizontal
    // raycasting so that it doesn't interfere with stepping through strings.
    BentoSetRaycastEnable(false, true);
}

//Since the player will want to click and drag this slider, we want to prevent drag movement being
//used to move a scroll parent.
BentoSetHoldBlocksDragScroll(true);

BentoLayoutSetMinSize(undefined, 80);

//Ensure the click function is scoped to this instance
func = method(self, func);

handleHover = false;
handleHold  = false;