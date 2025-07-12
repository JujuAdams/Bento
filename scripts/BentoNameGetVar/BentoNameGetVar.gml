// Feather disable all

/// Returns the value of a variable for the element with a matching name. If no element exists
/// or the named variable doesn't exist, this function will return the value provied by the
/// `default` parameter.
/// 
/// @param name
/// @param variableName
/// @param [default=undefined]
/// @param [environmentOrName=current]

function BentoNameGetVar(_name, _variableName, _default = undefined, _environmentOrName = undefined)
{
    var _element = BentoNameFind(_name, _environmentOrName);
    if (not BentoExists(_element)) return _default;
    if (not variable_struct_exists(_element, _variableName)) return _default;
    
    return _element[$ _variableName];
}