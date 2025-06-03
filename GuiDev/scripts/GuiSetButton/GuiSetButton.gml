// Feather disable all

/// @param buttonType
/// @param [element=self]

function GuiSetButton(_buttonType, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__buttonType == _buttonType) return;
        __buttonType = _buttonType;
        
        //Update data relating to buttons
        __layer.__dirtyFlags |= __GUI_DIRTY_STEP | __GUI_DIRTY_HOVERABLE;
    }
}