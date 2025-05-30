// Feather disable all

/// Returns whether an instance with the given name exists.
/// 
/// @param name
/// @param [layer=current]

function GuiNameExists(_name, _layer = undefined)
{
    static _system = __GuiSystem();
    
    _layer ??= _system.__layerCurrent;
    return GuiExists(_layer.__nameMap[? _name] ?? noone);
}