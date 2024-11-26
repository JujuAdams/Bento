// Feather disable all

/// @param state
/// @param [instance=id]

function GuiNavSetFocusable(_state, _instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (__focusable == _state) return;
        
        _system.__stepDirty = true;
        
        if (not _state) GuiNavSetFocus(false);
        __focusable = _state;
    }
    
}