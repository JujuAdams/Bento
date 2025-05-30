// Feather disable all

/// @param [horizontal]
/// @param [vertical]
/// @param [element=self]

function GuiLayoutSetListAlign(_horizontal, _vertical, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__layoutType != GUI_LAYOUT_LIST)
        {
            __GuiError("Can only set list child alignment for elements using a list layout");
        }
        
        if (_horizontal != undefined)
        {
            if (__layoutHAlignChildren != _horizontal)
            {
                __layoutHAlignChildren = _horizontal;
                __layer.__layoutDirty = true;
            }
        }
        
        if (_vertical != undefined)
        {
            if (__layoutVAlignChildren != _vertical)
            {
                __layoutVAlignChildren = _vertical;
                __layer.__layoutDirty = true;
            }
        }
    }
}