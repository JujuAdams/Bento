/// @param scope
/// @param variableName
/// @param start
/// @param end
/// @param duration
/// @param delay
/// @param animCurve

function __BentoClassAnimate(_scope, _variableName, _start, _end, _duration, _delay, _animCurve) constructor
{
    __scope = _scope;
    
    __variableName = _variableName;
    
    __value = _start;
    __start = _start;
    __end   = _end;
    
    __time     = 0;
    __duration = max(1, _duration);
    __delay    = max(0, _delay);
    
    __animCurve = _animCurve;
    
    __scope[$ __variableName] = __value;
    
    
    
    static __Update = function()
    {
        ++__time;
        
        var _t = clamp((__time - __delay) / __duration, 0, 1);
        
        if (__animCurve == undefined)
        {
            var _q = _t;
        }
        else
        {
            var _q = animcurve_channel_evaluate(animcurve_get_channel(__animCurve, 0), _t);
        }
        
        __value = lerp(__start, __end, _q);
        
        __scope[$ __variableName] = __value;
        
        return (_t >= 1);
    }
}