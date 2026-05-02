// Feather disable all

/// Returns a struct containing two variables (`.x` and `.y`) that are set to `true` or `fdlse`
/// depending on whether raycasting in enabled in each axis.
/// 
/// @param [element=self]

function BentoGetRaycastEnable(_disableHori, _disableVert, _element = self)
{
    static _result = {};
    
    if (not BentoExists(_element))
    {
        _result.x = _element.BENTO_VARS.__raycastEnableX;
        _result.y = _element.BENTO_VARS.__raycastEnableY;
    }
    else
    {
        _result.x = false;
        _result.y = false;
    }
    
    return _result;
}