// Feather disable all

/// Convenience function that sets a variable on an instance or struct if it has not already been
/// defined. Handy to set up default values in an object's Create event that can be overriden by
/// instance variables provided via the `var_struct` argument in `instance_create_depth()` and
/// `instance_create_layer()`.
/// 
/// @param variableName
/// @param value

function BentoVarEnsureMany()
{
    var _i = 0;
    repeat(argument_count div 2)
    {
        if (not variable_struct_exists(self, argument[_i]))
        {
            variable_struct_set(self, argument[_i], argument[_i+1]);
        }
        
        _i += 2;
    }
}