// Feather disable all

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

BentoVarEnsureMany(
    "reference", undefined,
    "text",      "",
    "emptyText", "",
    "func",      function() {}
);

BentoSetButton(BENTO_BUTTON_ALWAYS);
BentoLayoutSetSize(300);