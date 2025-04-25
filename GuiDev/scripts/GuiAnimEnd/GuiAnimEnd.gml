// Feather disable all

/// Unmarks an animating instance.
/// 
/// @param [instance=id]

function GuiAnimEnd(_instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
    {
        if (not __animating) return;
        
        __animating = false;
        _system.__animCount--;
    }
}