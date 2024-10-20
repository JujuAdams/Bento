// Feather disable all

/// @param state

function GuiFreezeGet(_state)
{
    static _system = __GuiSystem();
    
    return _system.__freeze;
}