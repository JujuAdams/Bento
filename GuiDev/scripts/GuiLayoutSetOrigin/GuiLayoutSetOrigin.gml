// Feather disable all

/// @param [x]
/// @param [y]
/// @param [element=self]

function GuiLayoutSetOrigin(_x, _y, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__layoutOriginAuto)
        {
            __layoutOriginAuto = false;
            __layer.__layoutDirty = true;
        }
        
        if (_x != undefined)
        {
            if (__layoutOriginX != _x)
            {
                __layoutOriginX = _x;
                __layer.__layoutDirty = true;
            }
        }
        
        if (_y != undefined)
        {
            if (__layoutOriginY != _y)
            {
                __layoutOriginY = _y;
                __layer.__layoutDirty = true;
            }
        }
    }
}