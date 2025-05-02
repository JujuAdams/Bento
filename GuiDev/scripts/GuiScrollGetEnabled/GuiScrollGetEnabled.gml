// Feather disable all

/// @param [instance=id]

function GuiScrollGetEnabled(_instance = id)
{
    static _result = {
        horizontal: false,
        vertical:   false,
    };
    
    if (instance_exists(_instance))
    {
        _result.horizontal = _instance.GUI_VARS.__scrollHori;
        _result.vertical   = _instance.GUI_VARS.__scrollVert;
    }
    else
    {
        _result.horizontal = false;
        _result.vertical   = false;
    }
    
    return _result;
}