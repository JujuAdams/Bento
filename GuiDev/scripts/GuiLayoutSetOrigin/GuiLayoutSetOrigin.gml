// Feather disable all

/// @param x
/// @param y
/// @param [element=self]
/// @param [percentage=true]

function GuiLayoutSetOrigin(_x, _y, _element = self, _proportional = true)
{
    if (not __GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__layoutOriginX != _x)
        {
            __layoutOriginX = _x;
            __layer.__layoutDirty = true;
        }
        
        if (__layoutOriginY != _y)
        {
            __layoutOriginY = _y;
            __layer.__layoutDirty = true;
        }
        
        if (__layoutOriginPerc != _proportional)
        {
            __layoutOriginPerc = _proportional;
            __layer.__layoutDirty = true;
        }
    }
}