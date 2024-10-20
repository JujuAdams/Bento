// Feather disable all

/// @param state

function GuiFreezeSetOnAnimation(_state)
{
    static _system = __GuiSystem();
    
    _system.__freezeOnAnimation = _state;
}