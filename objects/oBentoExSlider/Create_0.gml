// Feather disable all

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

BentoSetButton(BENTO_BUTTON_ALWAYS);

BentoSetRaycastEnable(false, true);

BentoVarEnsureMany(
    "reference",   undefined,
    "valueMin",    0,
    "valueMax",    10,
    "valueStep",   1,
    "handleWidth", undefined,
    "clickToSet",  true,
    "useFocus",    true,
    "func",        function() {}
);

//Ensure the click function is scoped to this instance
func = method(self, func);

handleHover = false;
handleHold  = false;