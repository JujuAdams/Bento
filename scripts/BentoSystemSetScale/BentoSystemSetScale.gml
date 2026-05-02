/// @param scale

function BentoSystemSetScale(_scale)
{
    static _system = __BentoSystem();
    
    with(_system)
    {
        if (__globalScale == _scale) return;
        
        var _multiplier = _scale / __globalScale;
        __globalScale = _scale;
        
        //TODO - Affect animations
    }
}