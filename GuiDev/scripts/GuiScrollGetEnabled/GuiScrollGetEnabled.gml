// Feather disable all

/// @param [instance=self]

function GuiScrollGetEnabled(_instance = self)
{
    static _result = {
        horizontal: false,
        vertical:   false,
    };
    
    if (GUI_EXISTS(_instance))
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