// Feather disable all

/// Returns whether the named button is being held based on input via `BentoInputHotkey()`.
/// 
/// @param name
/// @param [layerOrName=current]

function BentoHotkeyGetHold(_name, _layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if (__hotkeyConsumedMap[? _name] ?? false) return false;
        return (__hotkeyStateMap[? _name] == __BENTO_ON);
    }
    
    return false;
}