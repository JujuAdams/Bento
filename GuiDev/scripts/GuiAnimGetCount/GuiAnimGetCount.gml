// Feather disable all

/// Returns the total number of animating instances, as set by `GuiAnimStart()`.

function GuiAnimGetCount()
{
    static _system = __GuiSystem();
    
    return _system.__animCount;
}