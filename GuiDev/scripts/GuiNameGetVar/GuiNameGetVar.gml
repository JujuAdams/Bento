// Feather disable all

/// Returns the value of a variable for the instance with a matching name. If no instance exists
/// or the named variable doesn't exist, this function will return the value stored in the
/// `default` parameter.
/// 
/// @param name
/// @param variableName
/// @param [default=undefined]

function GuiNameGetVar(_name, _variableName, _default = undefined)
{
    var _element = GuiNameFind(_name);
    if (not __GuiExists(_element)) return _default;
    if (not variable_instance_exists(_element, _variableName)) return _default;
    
    return variable_instance_get(_element, _variableName);
}