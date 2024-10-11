// Feather disable all

/// @param instance

function GuiNavSelect(_instance)
{
    static _system = __GuiSystem();
    
    _system.__overInstance     = _instance;
    _system.__overInstanceSoft = noone;
}