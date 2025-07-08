// Feather disable all

/// Sets the origin of an element. This will override `BentoSetOriginAuto()`. The origin of an
/// element determines where the `bentoX` and `bentoY` coordinate is relative to the top-left
/// corner of the element.
/// 
/// N.B. The origin is defined proportional to the final width and height of the element. This is
///      different to the typical GameMaker left/center/right etc. constants.
/// 
/// The `x` and `y` parameters for this function should be given values from `0` to `1`. A value
/// of `0` indicates the left and top of the element, a value of `1` indicates the right and
/// bottom of the elelement. A value of `0.5` is accordingly the center/middle of the element.
/// 
/// @param [x]
/// @param [y]
/// @param [element=self]

function BentoSetOrigin(_x, _y, _element = self)
{
    var _changed = false;
    
    with(__BentoGetVars(_element))
    {
        if (__originAuto)
        {
            __originAuto = false;
            _changed = true;
        }
        
        if ((_x != undefined) && (__originX != _x))
        {
            __originX = _x;
            _changed = true;
        }
        
        if ((_y != undefined) && (__originY != _y))
        {
            __originY = _y;
            _changed = true;
        }
    }
    
    if (_changed)
    {
        with(_element)
        {
            __BentoUpdateElementXY();
        }
    }
}