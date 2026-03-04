/// @desc Draw Hover

if (BentoGetClickable())
{
    if (handleHover || handleHold)
    {
        var _smaller = 8;
        var _value = BentoRefGet(reference);
        var _stepCount   = ceil((valueMax - valueMin) / valueStep);
        var _handleStep  = min(_stepCount, floor((_value - valueMin) / valueStep));
        var _handleWidth = max(handleWidthMin, bentoWidth / _stepCount);
        var _handleLeft  = bentoLeft + _smaller + _handleStep*((bentoWidth - _handleWidth - 2*_smaller) / _stepCount);
        
        draw_sprite_stretched_ext(sBentoExHighlight, 0, _handleLeft+3 - 10, bentoTop+3 + _smaller - 10, _handleWidth + 20, bentoHeight - 2*_smaller + 20, c_black, 0.2);
        draw_sprite_stretched_ext(sBentoExHighlight, 0, _handleLeft - 10, bentoTop + _smaller - 10, _handleWidth + 20, bentoHeight - 2*_smaller + 20, BENTO_EXAMPLE_RED, 1);
    }
    else
    {
        BentoDrawSpriteAround(10, sBentoExHighlight, undefined, c_black, 0.2, un, 3, 3);
        BentoDrawSpriteAround(10, sBentoExHighlight, undefined, BENTO_EXAMPLE_RED);
    }
}