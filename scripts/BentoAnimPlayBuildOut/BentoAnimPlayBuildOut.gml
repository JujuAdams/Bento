// Feather disable all

/// Starts playing an animation set up for convenient use as a build-out. Once the animation has
/// finished playing, the element will be destroyed.
/// 
/// N.B. This is a **blocking** animation by default. Unless you set the optinal `blocking`
///      parameter to `false`, all user input to the element's layer will be ignored for the
///      duration of the animation. If you'd like to execute a callback once all animation has
///      finished, please use `BentoLayerSetUnblockCallback()`.
/// 
/// N.B. Only one animation per element can play at a time. This function will immediately stop
///      any animation playing on the element.
/// 
/// N.B. This function will overwrite any values previously set by the `BentoTransformSet*()`
///      functions. If the `alphaTo` parameter is set then this function will override the
///      `image_alpha` variable on the element itself.
/// 
/// The parameters for this function are the final values. The starting values will be derived
/// from the current transformation state of the element.
/// 
/// The `duration` and `delay` parameters are measured in frames. The `delay` parameter may be used
/// to defer execution of an animation which is helpful when triggering multiple animations at the
/// same time that you wish to be staggered.
/// 
/// @param duration
/// @param delay
/// @param xOffsetTo
/// @param yOffsetTo
/// @param xScaleTo
/// @param yScaleTo
/// @param [alphaTo]
/// @param [animCurve=linear]
/// @param [blocking=true]
/// @param [element=self]

function BentoAnimPlayBuildOut(_duration, _delay, _xTo, _yTo, _xScaleTo, _yScaleTo, _alphaTo = undefined, _animCurve = acBentoLinear, _element = self)
{
    if (not BentoExists(_element)) return;
    
    var _from = BentoTransformGetData(_element);
    BentoAnimPlayCustom(_duration, _delay,
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
                             __xScaleTo: _xScaleTo,
                             __yScaleTo: _yScaleTo,
                             __alphaTo:  _alphaTo,
                         },
                         function(_element, _t, _metadata)
                         {
                             var _q = animcurve_channel_evaluate(__curveChannel, _t);
                             
                             BentoTransformSetOffset(lerp(__xFrom, __xTo, _q), lerp(__yFrom, __yTo, _q), _element);
                             BentoTransformSetScale(lerp(__xScaleFrom, __xScaleTo, _q), lerp(__yScaleFrom, __yScaleTo, _q), _element);
                             
                             if (__alphaTo != undefined)
                             {
                                 _element.image_alpha = lerp(__alphaFrom, __alphaTo, _t); //Always linear
                             }
                             
                             if (_t >= 1)
                             {
                                 BentoDestroy(_element);
                             }
                         }),
                         undefined, true, _element);
}