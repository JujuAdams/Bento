// Feather disable all

/// @param axis
/// @param [instance=id]

function GuiLayoutSetListAxis(_axis, _instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (not variable_instance_exists(id, "__listAxis"))
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