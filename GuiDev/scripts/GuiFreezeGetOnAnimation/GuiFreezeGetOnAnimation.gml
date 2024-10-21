// Feather disable all

/// Returns whether the library should freeze user input when any instance has been set as "animating"
/// by `GuiAnimStart()`.

function GuiFreezeGetOnAnimation()
{
    static _system = __GuiSystem();
    
    return _system.__freezeOnAnimation;
}