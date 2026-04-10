// Feather disable all

/// Returns whether the named button has been pressed (newly held) based on input via
/// `BentoInputHotkey()`.
/// 
/// N.B. Button state is global. After processing button input, you should call `BentoInputConsume()`
///      to ensure button state doesn't leak to other elements.
/// 
/// @param name
/// @param [ignoreConsume=false]
/// @param [layerOrName=current]

function BentoHotkeyGetPress(_name, _ignoreConsume = false, _layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if ((not _ignoreConsume) && (__hotkeyConsumedMap[? _name] ?? false)) return false;
        return (__hotkeyStateMap[? _name] == __BENTO_STATE_START);
    }
    
    return false;
}