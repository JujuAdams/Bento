// Feather disable all

/// @desc Draw

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

draw_self();

if ((not (handleHover || handleHold)) && BentoCursorGetHover() && BentoGetClickable() && (BentoGetMode() != BENTO_MODE_TOUCH))
{
    gpu_set_fog(true, c_white, 0, 0);
    draw_sprite_stretched_ext(sprite_index, image_index, bentoLeft, bentoTop, bentoWidth, bentoHeight, image_blend, 0.5*image_alpha);
    gpu_set_fog(false, c_fuchsia, 0, 0);
}

var _value = BentoRefGet(reference);

var _stepCount   = ceil((valueMax - valueMin) / valueStep);
var _handleStep  = min(_stepCount, floor((_value - valueMin) / valueStep));
var _handleWidth = handleWidth ?? (bentoWidth / _stepCount);
var _handleLeft  = bentoLeft + _handleStep*((bentoWidth - _handleWidth) / _stepCount);

draw_sprite_stretched_ext(sBentoMaskRectangle, 0, _handleLeft, bentoTop, _handleWidth, bentoHeight, c_white, image_alpha);

if (handleHover || handleHold)
{
    gpu_set_fog(true, c_white, 0, 0);
    draw_sprite_stretched_ext(sBentoMaskRectangle, 0, _handleLeft, bentoTop, _handleWidth, bentoHeight, c_white, 0.5*image_alpha);
    gpu_set_fog(false, c_white, 0, 0);
}