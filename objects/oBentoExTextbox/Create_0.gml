// Feather disable all

//Always call this in the Create event in objects that inherit from `oBentoAncestor`
event_inherited();

BentoVarEnsureMany(
    "reference", undefined,
    "emptyText", "",
    "func",      function() {}
);

BentoSetButton(BENTO_BUTTON_ALWAYS);
BentoLayoutSetSize(300);

//Internal variable for this instance that's used to store the current text
__displayText = BentoRefGet(reference, "");