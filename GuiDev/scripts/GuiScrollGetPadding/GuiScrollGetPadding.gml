// Feather disable all

/// @param [instance=self]

function GuiScrollGetPadding(_instance = self)
{
    static _result = {};
    
    if (GUI_EXISTS(_instance) && _instance.GUI_VARS.__scrollHori && _instance.GUI_VARS.__scrollVert)
    {
        with(_instance.GUI_VARS)
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