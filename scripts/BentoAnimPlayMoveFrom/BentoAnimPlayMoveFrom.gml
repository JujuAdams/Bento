// Feather disable all

/// Starts playing an animation set up for convenient use to move an element from a previous
/// position to its current position. If you'd like this to be a blocking animation then please
/// set the optional `blocking` parameter to `true`. By default, however, animations played using
/// this function are non-blocking.
/// 
/// N.B. Only one animation per element can play at a time. This function will immediately stop
///      any animation playing on the element.
/// 
/// N.B. This function will overwrite any values previously set by the `BentoTransformSet*()`
///      functions.
/// 
/// The `duration` and `delay` parameters are measured in frames. The `delay` parameter may be used
/// to defer execution of an animation which is helpful when triggering multiple animations at the
/// same time that you wish to be staggered.
/// 
/// @param duration
/// @param delay
/// @param xFrom
/// @param yFrom
/// @param [animCurve=linear]
/// @param [blocking=false]
/// @param [element=self]

function BentoAnimPlayMoveFrom(_duration, _delay, _xFrom, _yFrom, _animCurve = acBentoLinear, _blocking = false, _element = self)
{
    if (not BentoExists(_element)) return;
    
    BentoAnimPlayCustom(_duration, _delay,
                         method(
                         {
                             __curveChannel: animcurve_get_channel(_animCurve, 0),
                             
                             __xFrom: _xFrom,
                             __yFrom: _yFrom,
                         },
                         function(_element, _t, _metadata)
                         {
                             var _q = animcurve_channel_evaluate(__curveChannel, _t);
                             BentoTransformSetPosition(lerp(__xFrom, _element.bentoX, _q), lerp(__yFrom, _element.bentoY, _q), _element);
                         }),
                         undefined, _blocking, _element);
}