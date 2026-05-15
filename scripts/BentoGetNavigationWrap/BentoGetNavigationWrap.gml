// Feather disable all

/// Returns a struct containing two variables (`.x` and `.y`) that are set to `true` or `fdlse`
/// depending on whether navigation wrapping in enabled in each axis.
/// 
/// @param [element=self]

function BentoGetNavigationWrap(_disableHori, _disableVert, _element = self)
{
    static _result = {};
    
    if (not BentoExists(_element))
    {
        _result.x = _element.BENTO_VARS.__navigationWrapX;
        _result.y = _element.BENTO_VARS.__navigationWrapY;
    }
    else
    {
        _result.x = false;
        _result.y = false;
    }
    
    return _result;
}