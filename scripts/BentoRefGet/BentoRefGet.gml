// Feather disable all

/// @param reference
/// @param [default]

function BentoRefGet(_reference, _default = undefined)
{
    var _scope = _reference.scope;
    var _variableName = _reference.variableName;
    
    if (_scope == global)
    {
        return variable_global_get(_reference.variableName);
    }
    else if (not weak_ref_alive(_scope))
    {
        return _default;
    }
    else
    {
        var _struct = _scope.ref;
        if (not variable_struct_exists(_struct, _variableName))
        {
            return _default;
        }
        else
        {
            return _struct[$ _variableName];
        }
    }
}