/// @function bento_variable_get(variableScope, variableName)
/// @param variableScope
/// @param variableName
function bento_variable_get(_scope, _variable_name)
{
    if (is_struct(_scope))
    {
        return variable_struct_get(_scope, _variable_name);
    }
    else if (_scope == global)
    {
        return variable_global_get(_variable_name);
    }
    else
    {
        return variable_instance_get(_scope, _variable_name);
    }
}