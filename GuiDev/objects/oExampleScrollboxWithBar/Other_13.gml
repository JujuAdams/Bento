/// @desc Reposition

// Feather disable all

event_inherited();

scrollbarLeft         = guiRight - scrollbarWidth - scrollbarPadding;
scrollbarTop          = guiTop + scrollbarPadding;
scrollbarRight        = guiRight - scrollbarPadding;
scrollbarBottom       = guiBottom - scrollbarPadding;
scrollbarHandleHeight = (scrollbarBottom - scrollbarTop) * clamp(guiHeight / GuiScrollGetHeight(), 0.1, 1);
scrollbarRangeHeight  = scrollbarBottom - scrollbarHandleHeight - scrollbarTop;