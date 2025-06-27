// Feather disable all

/// Sets a variable on an instance or struct if it has not already been defined.
/// 
/// @param variableName
/// @param value
/// @param [target=self]

function BentoSetIfNotDefined(_variableName, _value, _target = self)
{
    if (not variable_struct_exists(_target, _variableName))
    {
        variable_struct_set(_target, _variableName, _value);
    }
}