// Feather disable all

/// @param [instance=id]

function GuiScrollGetRegion(_instance = id)
{
    static _result = {};
    
    if (instance_exists(_instance) && _instance.__scissorState)
    {
        with(_instance)
        {
            _result.left   = __scissorLeft;
            _result.top    = __scissorTop;
            _result.right  = __scissorRight;
            _result.bottom = __scissorBottom;
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