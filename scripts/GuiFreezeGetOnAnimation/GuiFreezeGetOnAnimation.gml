// Feather disable all

function GuiFreezeGetOnAnimation()
{
    static _system = __GuiSystem();
    
    return _system.__freezeOnAnimation;
}