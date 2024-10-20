// Feather disable all

/// @param [instance=id]

function GuiAnimStart(_instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (__animating) return;
        
        __animating = true;
        _system.__animCount++;
    }
}