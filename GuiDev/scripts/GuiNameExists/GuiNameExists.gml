// Feather disable all

/// Returns whether an instance with the given name exists.
/// 
/// @param name
/// @param [environment=current]

function GuiNameExists(_name, _environment = undefined)
{
    static _system = __GuiSystem();
    
    _environment ??= _system.__environmentCurrent;
    return GUI_EXISTS(_environment.__nameMap[? _name] ?? noone);
}