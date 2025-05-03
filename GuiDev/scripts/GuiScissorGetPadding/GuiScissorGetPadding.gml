// Feather disable all

/// @param [element=self]

function GuiScissorGetPadding(_element = self)
{
    static _result = {};
    
    if (GUI_EXISTS(_element) && _element.GUI_VARS.__scissorEnabled)
    {
        with(_element.GUI_VARS)
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