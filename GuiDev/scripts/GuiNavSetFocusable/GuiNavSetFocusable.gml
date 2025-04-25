// Feather disable all

/// @param state
/// @param [instance=id]

function GuiNavSetFocusable(_state, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
    {
        if (__focusable == _state) return;
        
        _system.__stepDirty = true;
        
        if (not _state) GuiNavSetFocus(false, _instance);
        __focusable = _state;
    }
    
}