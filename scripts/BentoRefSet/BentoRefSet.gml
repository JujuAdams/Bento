// Feather disable all

/// Sets the value held by a reference. This reference must have been created by `BentoRef()`.
/// If the reference is no longer valid (the struct has fallen out of scope or has been destroyed)
/// then this function will silently fail.
/// 
/// This function returns whether the new value is different to the old value. If the reference is
/// invalid then this function will always return `false`.
/// 
/// @param reference
/// @param value

function BentoRefSet(_reference, _value)
{
    var _changed = false;
    
    var _scope = _reference.scope;
    var _variableName = _reference.variableName;
    
    if (_scope == global)
    {
        if (variable_global_exists(_variableName))
        {
            _changed = (variable_global_get(_variableName) != _value);
        }
        else
        {
            _changed = true;
        }
        
        variable_global_set(_variableName, _value);
    }
    else if (weak_ref_alive(_scope))
    {
        var _struct = _scope.ref;
        
        if (struct_exists(self, _variableName))
        {
            _changed = (_struct[$ _variableName] != _value);
        }
        else
        {
            _changed = true;
        }
        
        _struct[$ _variableName] = _value;
    }
    
    return _changed;
}