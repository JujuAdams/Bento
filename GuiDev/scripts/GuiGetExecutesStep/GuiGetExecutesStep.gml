// Feather disable all

/// @param [element=self]

function GuiGetExecutesStep(_element = self)
{
    if (not __GuiExists(_element)) return false;
    
    if (GUI_ALWAYS_EXECUTE_STEP) return true;
    
    with(_element.GUI_VARS)
    {
        //This should match the code in `__GuiEnsureStepOrderInner()`
        if (__disable) return false;
        if (__listener || __scissorEnabled || __focused) return true;
        if (__buttonType >= (__layer.__navPointer? GUI_BUTTON_POINTER : GUI_BUTTON_ALWAYS)) return true; //TODO - Cache the minimum button type when changing input mode
    }
    
    return false;
}