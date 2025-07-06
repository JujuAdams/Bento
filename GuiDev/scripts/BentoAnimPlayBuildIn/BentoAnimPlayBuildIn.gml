// Feather disable all

/// Starts playing an animation set up for convenient use as a build-in.
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
///      functions. If the `alphaFrom` parameter is set then this function will override the
///      `image_alpha` variable on the element itself.
/// 
/// The parameters for this function are the starting values for the animation. These values will\
/// be set immediately when the function is called. The final values are always `0,0` for the
/// offset and `1,1` for the scale. If the `alphaFrom` parameter is set to a number then the final
/// value for `image_alpha` will be `1`.
/// 
/// The `duration` and `delay` parameters are measured in frames. The `delay` parameter may be used
/// to defer execution of an animation which is helpful when triggering multiple animations at the
/// same time that you wish to be staggered.
/// 
/// @param duration
/// @param delay
/// @param xOffsetFrom
/// @param yOffsetFrom
/// @param xScaleFrom
/// @param yScaleFrom
/// @param [alphaFrom]
/// @param [animCurve=linear]
/// @param [blocking=true]
/// @param [element=self]

function BentoAnimPlayBuildIn(_duration, _delay, _xFrom, _yFrom, _xScaleFrom, _yScaleFrom, _alphaFrom = undefined, _animCurve = acBentoLinear, _blocking = true, _element = self)
{
    if (not BentoExists(_element)) return;
    
    BentoAnimPlayCustom(_duration, _delay,
                         method(
                         {
                             __curveChannel: animcurve_get_channel(_animCurve, 0),
                             
                             __xFrom:      _xFrom,
                             __yFrom:      _yFrom,
                             __xScaleFrom: _xScaleFrom,
                             __yScaleFrom: _yScaleFrom,
                             __alphaFrom:  _alphaFrom,
                             
                             __xTo:      0,
                             __yTo:      0,
                             __xScaleTo: 1,
                             __yScaleTo: 1,
                             __alphaTo:  1,
                         },
                         function(_element, _t, _metadata)
                         {
                             var _q = animcurve_channel_evaluate(__curveChannel, _t);
                             
                             BentoTransformSetOffset(lerp(__xFrom, __xTo, _q), lerp(__yFrom, __yTo, _q), _element);
                             BentoTransformSetScale(lerp(__xScaleFrom, __xScaleTo, _q), lerp(__yScaleFrom, __yScaleTo, _q), _element);
                             
                             if (__alphaFrom != undefined)
                             {
                                 _element.image_alpha = lerp(__alphaFrom, __alphaTo, _t); //Always linear
                             }
                         }),
                         undefined, _blocking, _element);
}