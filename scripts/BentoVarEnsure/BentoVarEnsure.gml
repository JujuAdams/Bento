// Feather disable all

/// Convenience function that sets a variable on an instance or struct if it has not already been
/// defined. Handy to set up default values in an object's Create event that can be overriden by
/// instance variables provided via the `var_struct` argument in `instance_create_depth()` and
/// `instance_create_layer()`.
/// 
/// @param variableName
/// @param value
/// @param [target=self]

function BentoVarEnsure(_variableName, _value, _target = self)
{
    if (not variable_struct_exists(_target, _variableName))
    {
        variable_struct_set(_target, _variableName, _value);
    }
}