// Feather disable all

/// @param [x]
/// @param [y]
/// @param [element=self]

function BentoSetOrigin(_x, _y, _element = self)
{
    if (not BentoExists(_element)) return;
    
    var _changed = false;
    
    with(_element.BENTO_VARS)
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