// Feather disable all

/// Sets the value of a variable for the instance with a matching name. If no instance exists
/// or the named variable doesn't exist, this function will silently fail.
/// 
/// @param name
/// @param variableName
/// @param value

function GuiNameSetVar(_name, _variableName, _value)
{
    var _instance = GuiNameFind(_name);
    if (not instance_exists(_instance)) return;
    
    variable_instance_set(_instance, _variableName, _value);
}