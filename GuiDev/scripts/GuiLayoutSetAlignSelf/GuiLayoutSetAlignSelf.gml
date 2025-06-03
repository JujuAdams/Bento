// Feather disable all

/// @param [hAlign]
/// @param [vAlign]
/// @param [element=self]

function GuiLayoutSetAlignSelf(_hAlign, _vAlign, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (_hAlign != undefined)
        {
            if (__layoutAlignH != _hAlign)
            {
                __layoutAlignH = _hAlign;
                __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
            }
        }
        
        if (_vAlign != undefined)
        {
            if (__layoutAlignV != _vAlign)
            {
                __layoutAlignV = _vAlign;
                __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
            }
        }
    }
}