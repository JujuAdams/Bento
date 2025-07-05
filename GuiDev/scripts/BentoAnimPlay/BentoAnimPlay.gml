// Feather disable all

/// Starts playing an aniamtion. This function allows you to adjust transform values over time
/// can be used to perform basic movement and scaling. This function further allows to you to
/// change the `image_alpha` variable on the element over time.
/// 
/// N.B. This function will overwrite any values previously set by the `BentoTransformSet*()`
///      functions. If the `alpha` parameter is set then this function will override the
///      `image_alpha` variable on the element itself.
/// 
/// The parameters for this function are the final values. The starting values will be derived
/// from the current transformation state of the element. The `duration` and `delay` parameters
/// are measured in frames. The `delay` parameter may be used to defer execution of an animation
/// which is helpful when triggering multiple animations at the same time that you wish to be
/// staggered.
/// 
/// @param duration
/// @param delay
/// @param xOffset
/// @param yOffset
/// @param scale
/// @param [alpha]
/// @param [animCurve=linear]
/// @param [element=self]

function BentoAnimPlay(_duration, _delay, _xTo, _yTo, _scaleTo, _alphaTo = undefined, _animCurve = acBentoLinear, _element = self)
{
    if (not BentoExists(_element)) return;
    
    var _from = BentoTransformGetData(_element);
    BentoAnimPlayMethod(_duration, _delay,
                         method(
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
                         function(_element, _t, _metadata)
                         {
                             var _q = animcurve_channel_evaluate(__curveChannel, _t);
                             
                             BentoTransformSetPosition(lerp(__xFrom, __xTo, _q), lerp(__yFrom, __yTo, _q), _element);
                             BentoTransformSetScale(lerp(__xScaleFrom, __xScaleTo, _q), lerp(__yScaleFrom, __yScaleTo, _q), _element);
                             
                             if (__alphaTo != undefined)
                             {
                                 _element.image_alpha = lerp(__alphaFrom, __alphaTo, _t); //Always linear
                             }
                         }),
                         undefined, _element);
}