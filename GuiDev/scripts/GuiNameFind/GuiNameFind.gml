// Feather disable all

/// Returns the `id` of the instance with a matching name. If no instance exists, this function
/// will return `GUI_NO_ELEMENT`.
/// 
/// @param name
/// @param [layer=current]

function GuiNameFind(_name, _layer = undefined)
{
    static _system = __GuiSystem();
    
    _layer ??= _system.__layerCurrent;
    return (_layer.__nameMap[? _name] ?? GUI_NO_ELEMENT);
}