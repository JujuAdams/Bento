// Feather disable all

/// @param axis
/// @param [element=self]

function GuiLayoutSetListAxis(_axis, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__layoutType != GUI_LAYOUT_LIST)
        {
            __GuiError("Can only apply list axis to elements using a list layout");
        }
        
        if (__listAxis != _axis)
        {
            __listAxis = _axis;
            __layer.__layoutDirty = true;
        }
    }
}