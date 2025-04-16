// Feather disable all

/// Sets a variable on an instance if it has not already been defined.
/// 
/// @param variableName
/// @param value
/// @param [instance=id]

function GuiSetIfNotDefined(_variableName, _value, _instance = id)
{
    if (not variable_instance_exists(_instance, _variableName))
    {
        variable_instance_set(_instance, _variableName, _value);
    }
}