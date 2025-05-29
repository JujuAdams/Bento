// Feather disable all

event_inherited();

GuiSetIfNotDefined("focusable", true);

GuiSetDrawAfter(true);

GuiScissorSetEnabled(true);
GuiScrollSetEnabled(true, true);

GuiSetButton(GUI_BUTTON_ALWAYS);
GuiFocusSetEncloseChildren(true);

scrollbarWidth   = 10;
scrollbarPadding = 10;

overScrollbar = false;
overHandle = false;

handleGrabbed = false;
handleGrabbedRelativeY = 0;

scrollbarLeft         = 0;
scrollbarTop          = 0;
scrollbarRight        = 0;
scrollbarBottom       = 0;
scrollbarHandleHeight = 0;
scrollbarHandleTop    = 0;
scrollbarHandleBottom = 0;
scrollbarRangeHeight  = 0;