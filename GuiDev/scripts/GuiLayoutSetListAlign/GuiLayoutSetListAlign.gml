// Feather disable all

/// @param [horizontal]
/// @param [vertical]
/// @param [element=self]

function GuiLayoutSetListAlign(_horizontal, _vertical, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (not variable_struct_exists(self, "__layoutHAlignChildren"))
        {
            __GuiError("Can only set list child alignment on objects that inherit from `oGuiLibList`");
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