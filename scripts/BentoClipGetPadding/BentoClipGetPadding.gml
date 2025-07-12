// Feather disable all

/// Returns a struct containing four variables (`.left` `.top` `.right` `.bottom`) that contain
/// the padding values for the clipping region, as set by `BentoClipSetPadding()`.
/// 
/// @param [element=self]

function BentoClipGetPadding(_element = self)
{
    static _result = {};
    
    if (BentoExists(_element) && _element.BENTO_VARS.__scissorEnabled)
    {
        with(_element.BENTO_VARS)
        {
            _result.left   = __scissorPadLeft;
            _result.top    = __scissorPadTop;
            _result.right  = __scissorPadRight;
            _result.bottom = __scissorPadBottom;
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