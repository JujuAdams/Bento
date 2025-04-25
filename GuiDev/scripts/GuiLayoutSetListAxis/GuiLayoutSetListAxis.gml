// Feather disable all

/// @param axis
/// @param [instance=id]

function GuiLayoutSetListAxis(_axis, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    if (not variable_instance_exists(_instance, "__listAxis"))
    {
        __GuiError("Can only apply list axis to objects that inherit from `oGuiLibList`");
    }
    
    with(_instance.__gui)
    {
        if (__listAxis != _axis)
        {
            __listAxis = _axis;
            _system.__layoutDirty = true;
        }
    }
}