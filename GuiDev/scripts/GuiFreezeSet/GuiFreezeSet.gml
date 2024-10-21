// Feather disable all

/// Freezes user input for the library.
/// 
/// @param state

function GuiFreezeSet(_state)
{
    static _system = __GuiSystem();
    
    _system.__freeze = _state;
}