// Feather disable all

/// @param [instance=id]

function GuiScissorGetPadding(_instance = id)
{
    static _result = {};
    
    if (instance_exists(_instance) && _instance.__scissorEnabled)
    {
        with(_instance)
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