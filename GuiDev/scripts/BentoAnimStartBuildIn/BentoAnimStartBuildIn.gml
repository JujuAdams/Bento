// Feather disable all

/// @param [xFrom=0]
/// @param [yFrom=0]
/// @param [scaleFrom=1]
/// @param [alphaFrom]
/// @param duration
/// @param [animCurve=linear]
/// @param [element=self]

function BentoAnimStartBuildIn(_xFrom = 0, _yFrom = 0, _scaleFrom = 1, _alphaFrom = undefined, _duration, _animCurve = __acBentoLinear, _element = self)
{
    BentoAnimStartMethod(method(
    {
        __curveChannel: animcurve_get_channel(_animCurve, 0),
        
        __xFrom:      _xFrom,
        __yFrom:      _yFrom,
        __xScaleFrom: _scaleFrom,
        __yScaleFrom: _scaleFrom,
        __alphaFrom:  _alphaFrom,
        
        __xTo:      0,
        __yTo:      0,
        __xScaleTo: 1,
        __yScaleTo: 1,
        __alphaTo:  1,
    },
    function(_t, _metadata)
    {
        var _q = animcurve_channel_evaluate(__curveChannel, _t);
        
        BentoTransformSetPosition(lerp(__xFrom, __xTo, _q), lerp(__yFrom, __yTo, _q), _metadata);
        BentoTransformSetScale(lerp(__xScaleFrom, __xScaleTo, _q), lerp(__yScaleFrom, __yScaleTo, _q), _metadata);
        
        if (__alphaFrom != undefined)
        {
            _metadata.image_alpha = lerp(__alphaFrom, __alphaTo, _q);
        }
    }),
    _duration, false, _element);
}