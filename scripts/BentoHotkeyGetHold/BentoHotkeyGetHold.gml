// Feather disable all

/// Returns whether the named button is being held based on input via `BentoInputHotkey()`.
/// 
/// @param name
/// @param [ignoreConsume=false]
/// @param [layerOrName=current]

function BentoHotkeyGetHold(_name, _ignoreConsume = false, _layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if ((not _ignoreConsume) && (__hotkeyConsumedMap[? _name] ?? false)) return false;
        return (__hotkeyStateMap[? _name] == __BENTO_STATE_ON);
    }
    
    return false;
}