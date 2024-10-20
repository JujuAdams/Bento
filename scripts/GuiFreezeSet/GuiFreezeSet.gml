// Feather disable all

/// @param state

function GuiFreezeSet(_state)
{
    static _system = __GuiSystem();
    
    _system.__freeze = _state;
}