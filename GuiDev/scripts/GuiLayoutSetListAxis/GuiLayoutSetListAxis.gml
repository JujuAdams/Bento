// Feather disable all

/// @param axis
/// @param [instance=self]

function GuiLayoutSetListAxis(_axis, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (not variable_struct_exists(self, "__listAxis"))
        {
            __GuiError("Can only apply list axis to objects that inherit from `oGuiLibList`");
        }
        
        if (__listAxis != _axis)
        {
            __listAxis = _axis;
            __environment.__layoutDirty = true;
        }
    }
}