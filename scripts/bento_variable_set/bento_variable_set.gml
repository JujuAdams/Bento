/// @function bento_variable_set(variableScope, variableName, value)
/// @param variableScope
/// @param variableName
/// @param value
function bento_variable_set(_scope, _variable_name, _value)
{
    if (is_struct(_scope))
    {
        return variable_struct_set(_scope, _variable_name, _value);
    }
    else if (_scope == global)
    {
        return variable_global_set(_variable_name, _value);
    }
    else
    {
        return variable_instance_set(_scope, _variable_name, _value);
    }
}