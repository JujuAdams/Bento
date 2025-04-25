// Feather disable all

/// @param [instance=id]

function GuiScrollGetPadding(_instance = id)
{
    static _result = {};
    
    if (instance_exists(_instance) && _instance.__gui.__scrollHori && _instance.__gui.__scrollVert)
    {
        with(_instance.__gui)
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