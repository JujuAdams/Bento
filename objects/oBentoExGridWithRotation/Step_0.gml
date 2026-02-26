// Feather disable all

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

BentoTransformSetAngle(current_time/20);
BentoTransformSetScale(mouse_x/room_width, mouse_x/room_width);