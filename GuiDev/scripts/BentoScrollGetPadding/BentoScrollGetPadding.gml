// Feather disable all

/// @param [element=self]

function BentoScrollGetPadding(_element = self)
{
    static _result = {};
    
    if (BentoExists(_element) && _element.GUI_VARS.__scrollHori && _element.GUI_VARS.__scrollVert)
    {
        with(_element.GUI_VARS)
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