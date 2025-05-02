// Feather disable all

/// @param state
/// @param [instance=self]

function GuiNavSetFocusable(_state, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (__focusable == _state) return;
        
        __environment.__stepDirty = true;
        
        if (not _state) GuiNavSetFocus(false, _instance);
        __focusable = _state;
    }
    
}