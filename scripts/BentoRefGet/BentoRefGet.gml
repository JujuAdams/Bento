// Feather disable all

/// Returns the value held by a reference. This reference must have been created by
/// `BentoRef()`. If the reference is no longer valid (the struct has fallen out of scope or
/// has been destroyed) then the `default` value is returned.
/// 
/// @param reference
/// @param [default=undefined]

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