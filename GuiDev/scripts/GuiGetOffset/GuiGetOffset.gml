// Feather disable all

/// @param [element=self]

function GuiGetOffset(_element = self)
{
    static _result = {
        x: 0,
        y: 0,
    };
    
    if (GuiExists(_element))
    {
        with(_element.GUI_VARS)
        {
            _result.x = __offsetX;
            _result.y = __offsetY;
        }
    }
    else
    {
        _result.x = 0;
        _result.y = 0;
    }
    
    return _result;
}