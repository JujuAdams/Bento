// Feather disable all

/// @param name

function GuiNameExists(_name)
{
    static _nameMap = __GuiSystem().__nameMap;
    
    return instance_exists(_nameMap[? _name] ?? noone);
}