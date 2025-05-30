// Feather disable all

/// @param axis
/// @param [element=self]

function GuiLayoutSetListAxis(_axis, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (not variable_struct_exists(self, "__listAxis"))
        {
            __GuiError("Can only apply list axis to objects that inherit from `oGuiLibList`");
        }
        
        if (__listAxis != _axis)
        {
            __listAxis = _axis;
            __layer.__layoutDirty = true;
        }
    }
}