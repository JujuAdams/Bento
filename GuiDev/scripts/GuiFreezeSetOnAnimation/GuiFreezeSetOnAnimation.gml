// Feather disable all

/// Sets whether the library should freeze user input when any instance has been set as "animating"
/// by `GuiAnimStart()`.
/// 
/// @param state

function GuiFreezeSetOnAnimation(_state)
{
    static _system = __GuiSystem();
    
    _system.__freezeOnAnimation = _state;
}