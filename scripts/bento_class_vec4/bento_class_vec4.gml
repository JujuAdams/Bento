/// @param name

function bento_class_vec4(_name) constructor
{
    name = _name;
    
    l = 0;
    t = 0;
    r = 0;
    b = 0;
    
    /// @param value
    clear = function(_value)
    {
        l = _value;
        t = _value;
        r = _value;
        b = _value;
    }
    
    /// @param vec4
    copy = function(_vec4)
    {
        l = _vec4.l;
        t = _vec4.t;
        r = _vec4.r;
        b = _vec4.b;
    }
    
    /// @param vec4
    add_outside = function(_vec4)
    {
        l -= _vec4.l;
        t -= _vec4.t;
        r += _vec4.r;
        b += _vec4.b;
    }
    
    /// @param vec4
    add_inside = function(_vec4)
    {
        l += _vec4.l;
        t += _vec4.t;
        r -= _vec4.r;
        b -= _vec4.b;
    }
}