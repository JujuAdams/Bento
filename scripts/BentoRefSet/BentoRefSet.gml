// Feather disable all

/// @param reference
/// @param value

function BentoRefSet(_reference, _value)
{
    var _scope = _reference.scope;
    var _variableName = _reference.variableName;
    
    if (_scope == global)
    {
        variable_global_set(_reference.variableName, _value);
    }
    else if (weak_ref_alive(_scope))
    {
        _scope.ref[$ _variableName] = _value;
    }
}