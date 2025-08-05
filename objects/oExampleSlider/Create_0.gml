// Feather disable all

event_inherited();

BentoSetButton(BENTO_BUTTON_ALWAYS);

BentoSetRaycastEnable(false, true);

BentoSetIfNotDefined("reference", undefined);
BentoSetIfNotDefined("valueMin", 0);
BentoSetIfNotDefined("valueMax", 10);
BentoSetIfNotDefined("valueStep", 1);
BentoSetIfNotDefined("handleWidth", undefined);
BentoSetIfNotDefined("clickToSet", true);
BentoSetIfNotDefined("useFocus", true);

handleHover = false;
handleHold  = false;