// Feather disable all

/// @param [xTo=0]
/// @param [yTo=0]
/// @param [scaleTo=1]
/// @param [alphaTo]
/// @param duration
/// @param [animCurve=linear]
/// @param [element=self]

function BentoAnimStartBuildOut(_xTo = 0, _yTo = 0, _scaleTo = 1, _alphaTo = undefined, _duration, _animCurve = __acBentoLinear, _element = self)
{
    var _from = BentoTransformGetData(_element);
    BentoAnimStartMethod(method(
    {
        __curveChannel: animcurve_get_channel(_animCurve, 0),
        
        __xFrom:      _from.xOffset,
        __yFrom:      _from.yOffset,
        __xScaleFrom: _from.xScale,
        __yScaleFrom: _from.yScale,
        __alphaFrom:  _element.image_alpha,
        
        __xTo:      _xTo,
        __yTo:      _yTo,
        __xScaleTo: _scaleTo,
        __yScaleTo: _scaleTo,
        __alphaTo:  _alphaTo,
    },
    function(_t, _metadata)
    {
        var _q = animcurve_channel_evaluate(__curveChannel, _t);
        
        BentoTransformSetPosition(lerp(__xFrom, __xTo, _q), lerp(__yFrom, __yTo, _q), _metadata);
        BentoTransformSetScale(lerp(__xScaleFrom, __xScaleTo, _q), lerp(__yScaleFrom, __yScaleTo, _q), _metadata);
        
        if (__alphaTo != undefined)
        {
            _metadata.image_alpha = lerp(__alphaFrom, __alphaTo, _q);
        }
    }),
    _duration, true, _element);
}