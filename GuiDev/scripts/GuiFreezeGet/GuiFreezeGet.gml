// Feather disable all

/// Returns if user input has been frozen by `GuiFreezeSet()` specifically. If you want to check if
/// user input has been frozen in general then you should call `GuiFreezeGetAny()`.
/// 
/// @param state

function GuiFreezeGet(_state)
{
    static _system = __GuiSystem();
    
    return _system.__freeze;
}