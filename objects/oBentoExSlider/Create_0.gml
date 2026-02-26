// Feather disable all

event_inherited();

BentoSetButton(BENTO_BUTTON_ALWAYS);

BentoSetRaycastEnable(false, true);

BentoVarEnsure("reference", undefined);
BentoVarEnsure("valueMin", 0);
BentoVarEnsure("valueMax", 10);
BentoVarEnsure("valueStep", 1);
BentoVarEnsure("handleWidth", undefined);
BentoVarEnsure("clickToSet", true);
BentoVarEnsure("useFocus", true);

handleHover = false;
handleHold  = false;