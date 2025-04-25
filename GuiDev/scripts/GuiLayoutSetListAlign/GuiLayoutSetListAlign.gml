// Feather disable all

/// @param [horizontal]
/// @param [vertical]
/// @param [instance=id]

function GuiLayoutSetListAlign(_horizontal, _vertical, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
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
                _system.__layoutDirty = true;
            }
        }
        
        if (_vertical != undefined)
        {
            if (__layoutVAlignChildren != _vertical)
            {
                __layoutVAlignChildren = _vertical;
                _system.__layoutDirty = true;
            }
        }
    }
}