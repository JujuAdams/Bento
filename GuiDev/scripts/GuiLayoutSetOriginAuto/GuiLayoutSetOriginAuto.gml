// Feather disable all

/// @param [element=self]

function GuiLayoutSetOriginAuto(_element = self)
{
    if (not __GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__GuiIsInstance(__attachedElement) && (not __layoutOriginAuto))
        {
            __layoutOriginAuto = true;
            __layer.__layoutDirty = true;
        }
    }
}