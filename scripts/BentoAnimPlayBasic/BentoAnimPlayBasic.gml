// Feather disable all

/// Starts playing an animation. This function allows you to adjust transform values over time
/// can be used to perform basic movement and scaling. If you'd like this to be a blocking
/// animation then please set the optional `blocking` parameter to `true`. By default, however,
/// animations played using this function are non-blocking.
/// 
/// N.B. Only one animation per element can play at a time. This function will immediately stop
///      any animation playing on the element.
/// 
/// N.B. This function will overwrite any values previously set by the `BentoTransformSet*()`
///      functions.
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
/// @param xScale
/// @param yScale
/// @param [animCurve=linear]
/// @param [blocking=false]
/// @param [element=self]

function BentoAnimPlayBasic(_duration, _delay, _xTo, _yTo, _xScaleTo, _yScaleTo, _animCurve = acBentoLinear, _blocking = false, _element = self)
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
                             
                             __xTo:      _xTo,
                             __yTo:      _yTo,
                             __xScaleTo: _xScaleTo,
                             __yScaleTo: _yScaleTo,
                         },
                         function(_element, _t, _metadata)
                         {
                             var _q = animcurve_channel_evaluate(__curveChannel, _t);
                             
                             BentoTransformSetOffset(lerp(__xFrom, __xTo, _q), lerp(__yFrom, __yTo, _q), _element);
                             BentoTransformSetScale(lerp(__xScaleFrom, __xScaleTo, _q), lerp(__yScaleFrom, __yScaleTo, _q), _element);
                         }),
                         undefined, _blocking, _element);
}