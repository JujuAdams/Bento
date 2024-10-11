// Feather disable all

/// @param name

function GuiFindByName(_name)
{
    static _nameMap = __GuiSystem().__nameMap;
    
    return (_nameMap[? _name] ?? noone);
}