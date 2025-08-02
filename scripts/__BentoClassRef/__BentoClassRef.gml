// Feather disable all

/// @param struct
/// @param variableName

function __BentoClassRef(_struct, _variableName) constructor
{
    if (not variable_struct_exists(_struct, _variableName))
    {
        __BentoError($"Variable \"{_variableName}\" doesn't exist in the given struct");
    }
    
    scope        = (_struct == global)? _struct : weak_ref_create(_struct);
    variableName = _variableName;
}