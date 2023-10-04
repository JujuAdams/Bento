/// @param scope
/// @param variableName
/// @param start
/// @param end
/// @param duration
/// @param delay

function __BentoClassAnimate(_scope, _variableName, _start, _end, _duration, _delay) constructor
{
    __scope = _scope;
    
    __variableName = _variableName;
    
    __value = _start;
    __start = _start;
    __end   = _end;
    
    __time     = 0;
    __duration = max(1, _duration);
    __delay    = max(0, _delay);
    
    __scope[$ __variableName] = __value;
    
    
    
    static __Update = function()
    {
        ++__time;
        
        var _t = clamp((__time - __delay) / __duration, 0, 1);
        __value = lerp(__start, __end, _t);
        
        __scope[$ __variableName] = __value;
        
        return (_t >= 1);
    }
}