// Feather disable all

/// @param [instance=id]

function GuiAnimEnd(_instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (not __animating) return;
        
        __animating = false;
        _system.__animCount--;
    }
}