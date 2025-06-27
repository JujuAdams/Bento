// Feather disable all

/// Sets the value of a variable for the instance with a matching name. If no instance exists
/// or the named variable doesn't exist, this function will silently fail.
/// 
/// @param name
/// @param variableName
/// @param value

function BentoNameSetVar(_name, _variableName, _value)
{
    var _element = BentoNameFind(_name);
    if (not BentoExists(_element)) return;
    
    variable_instance_set(_element, _variableName, _value);
}