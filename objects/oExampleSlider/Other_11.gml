/// @desc Draw

// Feather disable all

event_inherited();

draw_self();

var _value = BentoRefGet(reference);

var _stepCount   = ceil((valueMax - valueMin) / valueStep);
var _handleStep  = min(_stepCount, floor((_value - valueMin) / valueStep));
var _handleWidth = handleWidth ?? (bentoWidth / _stepCount);
var _handleLeft  = bentoLeft + _handleStep*((bentoWidth - _handleWidth) / _stepCount);

gpu_set_fog(handleHover, c_white, 0, 0);
draw_sprite_stretched(sBentoMaskRectangle, 0, _handleLeft, bentoTop, _handleWidth, bentoHeight);
gpu_set_fog(false, c_white, 0, 0);