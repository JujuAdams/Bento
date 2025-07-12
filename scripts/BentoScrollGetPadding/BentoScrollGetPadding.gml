// Feather disable all

/// Returns a struct containing four variables (`.left` `.top` `.right` `.bottom`) that contain
/// the padding values for the scroll area, as set by `BentoScrollSetPadding()`.
/// 
/// @param [element=self]

function BentoScrollGetPadding(_element = self)
{
    static _result = {};
    
    if (BentoExists(_element) && _element.BENTO_VARS.__scrollHori && _element.BENTO_VARS.__scrollVert)
    {
        with(_element.BENTO_VARS)
        {
            _result.left   = __scrollPadLeft;
            _result.top    = __scrollPadTop;
            _result.right  = __scrollPadRight;
            _result.bottom = __scrollPadBottom;
        }
    }
    else
    {
        _result.left   = 0;
        _result.top    = 0;
        _result.right  = 0;
        _result.bottom = 0;
    }
    
    return _result;
}