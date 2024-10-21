// Feather disable all

/// Returns whether an instance with the given name exists.
/// 
/// @param name

function GuiNameExists(_name)
{
    static _nameMap = __GuiSystem().__nameMap;
    
    return instance_exists(_nameMap[? _name] ?? noone);
}