// Feather disable all

function GuiFreezeGetAny()
{
    static _system = __GuiSystem();
    
    with(_system)
    {
        if (__freeze) return true;
        if (__freezeOnAnimation & (__animCount > 0)) return true;
    }
    
    return false;
}