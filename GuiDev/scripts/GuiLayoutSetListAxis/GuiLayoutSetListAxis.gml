// Feather disable all

/// @param axis
/// @param [instance=id]

function GuiLayoutSetListAxis(_axis, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    with(_instance.__gui)
    {
        if (not variable_struct_exists(self, "__listAxis"))
        {
            __GuiError("Can only apply list axis to objects that inherit from `oGuiLibList`");
        }
        
        if (__listAxis != _axis)
        {
            __listAxis = _axis;
            _system.__layoutDirty = true;
        }
    }
}