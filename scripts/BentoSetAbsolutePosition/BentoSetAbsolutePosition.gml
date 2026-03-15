// Feather disable all

/// @param x
/// @param y
/// @param [element=self]

function BentoSetAbsolutePosition(_x, _y, _element = self)
{
    static _system = __BentoSystem();
    
    with(__BentoGetVars(_element))
    {
        with(__layer)
        {
            __BentoEnsureLayout();
            __BentoEnsureOffset();
        }
        
        _x /= _system.__globalScale;
        _y /= _system.__globalScale;
        
        BentoSetOffset(_x - _element.bentoX, _y - _element.bentoY, _element);
    }
}