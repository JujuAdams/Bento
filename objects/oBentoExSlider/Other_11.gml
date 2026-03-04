// Feather disable all

/// @desc Draw

draw_sprite_ext(sBentoExButton, image_index, x, y, image_xscale, image_yscale, image_angle, BENTO_EXAMPLE_BLUE, image_alpha);
draw_sprite_ext(sBentoExFrameShadow, image_index, x+4, y+4, image_xscale, image_yscale, image_angle, c_black, 0.5);

var _smaller = 8;
var _value = BentoRefGet(reference);
var _stepCount   = ceil((valueMax - valueMin) / valueStep);
var _handleStep  = min(_stepCount, floor((_value - valueMin) / valueStep));
var _handleWidth = max(handleWidthMin, bentoWidth / _stepCount);
var _handleLeft  = bentoLeft + _smaller + _handleStep*((bentoWidth - _handleWidth - 2*_smaller) / _stepCount);

draw_sprite_stretched_ext(sBentoExButton, 0, _handleLeft+4, bentoTop+4 + _smaller, _handleWidth, bentoHeight - 2*_smaller, c_black, 0.5);
draw_sprite_stretched_ext(sBentoExButton, 0, _handleLeft, bentoTop + _smaller, _handleWidth, bentoHeight - 2*_smaller, BENTO_EXAMPLE_YELLOW, image_alpha);

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);