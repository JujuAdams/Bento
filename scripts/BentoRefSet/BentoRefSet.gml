// Feather disable all

/// Sets the value held by a reference. This reference must have been created by `BentoRefCreate()`.
/// If the reference is no longer valid (the struct has fallen out of scope or has been destroyed)
/// then this function will silently fail.
/// 
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