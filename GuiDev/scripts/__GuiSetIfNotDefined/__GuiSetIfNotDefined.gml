// Feather disable all

/// Sets a variable on an instance if it has not already been defined.
/// 
/// @param instance
/// @param variableName
/// @param value

function __GuiSetIfNotDefined(_instance, _variableName, _value)
{
    if (not variable_instance_exists(_instance, _variableName))
    {
        variable_instance_set(_instance, _variableName, _value);
    }
}