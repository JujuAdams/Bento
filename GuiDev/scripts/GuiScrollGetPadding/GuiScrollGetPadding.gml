// Feather disable all

/// @param [instance=id]

function GuiScrollGetPadding(_instance = id)
{
    static _result = {};
    
    if (instance_exists(_instance) && _instance.GUI_STRUCT.__scrollHori && _instance.GUI_STRUCT.__scrollVert)
    {
        with(_instance.GUI_STRUCT)
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