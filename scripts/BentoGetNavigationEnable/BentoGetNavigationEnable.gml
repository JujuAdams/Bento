// Feather disable all

/// Returns a struct containing two variables (`.x` and `.y`) that are set to `true` or `fdlse`
/// depending on whether navigation in enabled in each axis.
/// 
/// @param [element=self]

function BentoGetNavigationEnable(_disableHori, _disableVert, _element = self)
{
    static _result = {};
    
    if (not BentoExists(_element))
    {
        _result.x = _element.BENTO_VARS.__navigationEnableX;
        _result.y = _element.BENTO_VARS.__navigationEnableY;
    }
    else
    {
        _result.x = false;
        _result.y = false;
    }
    
    return _result;
}