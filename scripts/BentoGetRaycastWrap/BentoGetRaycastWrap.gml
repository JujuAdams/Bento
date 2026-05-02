// Feather disable all

/// Returns a struct containing two variables (`.x` and `.y`) that are set to `true` or `fdlse`
/// depending on whether raycast wrapping in enabled in each axis.
/// 
/// @param [element=self]

function BentoGetRaycastWrap(_disableHori, _disableVert, _element = self)
{
    static _result = {};
    
    if (not BentoExists(_element))
    {
        _result.x = _element.BENTO_VARS.__raycastWrapX;
        _result.y = _element.BENTO_VARS.__raycastWrapY;
    }
    else
    {
        _result.x = false;
        _result.y = false;
    }
    
    return _result;
}