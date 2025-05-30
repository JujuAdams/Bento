// Feather disable all

/// @param [element=self]

function GuiScrollGetEnabled(_element = self)
{
    static _result = {
        horizontal: false,
        vertical:   false,
    };
    
    if (GuiExists(_element))
    {
        _result.horizontal = _element.GUI_VARS.__scrollHori;
        _result.vertical   = _element.GUI_VARS.__scrollVert;
    }
    else
    {
        _result.horizontal = false;
        _result.vertical   = false;
    }
    
    return _result;
}