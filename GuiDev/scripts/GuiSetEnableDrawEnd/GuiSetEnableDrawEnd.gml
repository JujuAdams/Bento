// Feather disable all

/// Sets whether an instance should execute its Draw Event user event (`GUI_USER_EVENT_DRAW_END`).
/// The Draw End user event is executed after the Draw user event (`GUI_USER_EVENT_DRAW`) and after
/// drawing child instance that are marked as "inside". However, the Draw End user event is
/// executed *before* outside child instances.
/// 
/// @param state
/// @param [element=self]

function GuiSetEnableDrawEnd(_state, _element = self)
{
    if (not GUI_EXISTS(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__drawEnd == _state) return;
        __drawEnd = _state;
        
        __layer.__drawDirty = true;
    }
}