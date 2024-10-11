// Feather disable all

/// @param name
/// @param variableName
/// @param value

function GuiNameSetVar(_name, _variableName, _value)
{
    var _instance = GuiFindByName(_name);
    if (not instance_exists(_instance)) return;
    
    variable_instance_set(_instance, _variableName, _value);
}