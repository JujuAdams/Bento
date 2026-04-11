/// @desc Draw Dragged Item

var _oldAlpha = image_alpha;
image_alpha *= 0.66;
event_user(BENTO_USER_EVENT_DRAW);
image_alpha = _oldAlpha;