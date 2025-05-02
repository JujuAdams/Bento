// Feather disable all

/// Returns the `id` of the instance with a matching name. If no instance exists, this function
/// will return `noone`.
/// 
/// @param name
/// @param [environment=current]

function GuiNameFind(_name, _environment = undefined)
{
    static _system = __GuiSystem();
    
    _environment ??= _system.__environmentCurrent;
    return (_environment.__nameMap[? _name] ?? noone);
}