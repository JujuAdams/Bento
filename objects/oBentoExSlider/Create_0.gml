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
    // We disable horizontal navigation so that players can move the slider without jumping to
    // another element
    BentoSetNavigationEnable(false, true);
}

//Since the player will want to click and drag this slider, we want to prevent drag movement being
//used to move a scroll parent.
BentoSetHoldBlocksDragScroll(true);

BentoLayoutSetMinSize(undefined, 80);

//Ensure the click function is scoped to this instance
func = method(self, func);

handleHover = false;
handleHold  = false;