// Feather disable all

/// Marks an instance as "animating". This doesn't inherently do anything to the instance - you
/// need to manage the animation yourself - but it does freeze user input (i.e. if any instance is
/// animating then the library will ignore user input).
/// 
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