// Feather disable all

/// @param [horizontal]
/// @param [vertical]
/// @param [instance=self]

function GuiLayoutSetListAlign(_horizontal, _vertical, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
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
                __environment.__layoutDirty = true;
            }
        }
        
        if (_vertical != undefined)
        {
            if (__layoutVAlignChildren != _vertical)
            {
                __layoutVAlignChildren = _vertical;
                __environment.__layoutDirty = true;
            }
        }
    }
}