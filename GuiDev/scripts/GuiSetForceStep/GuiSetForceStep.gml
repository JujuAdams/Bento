// Feather disable all

/// @param state
/// @param [element=self]

function GuiSetForceStep(_state, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__forceStep == _state) return;
        __forceStep = _state;
        
        __layer.__stepDirty = true;
    }
}