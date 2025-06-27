// Feather disable all

/// Returns whether an instance with the given name exists.
/// 
/// @param name
/// @param [layer=current]

function BentoNameExists(_name, _layer = undefined)
{
    static _system = __BentoSystem();
    
    _layer ??= _system.__layerCurrent;
    return BentoExists(_layer.__nameMap[? _name] ?? GUI_NO_ELEMENT);
}