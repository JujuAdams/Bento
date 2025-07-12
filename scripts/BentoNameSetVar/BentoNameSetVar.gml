// Feather disable all

/// Sets the value of a variable for the element with a matching name. If no element exists
/// or the named variable doesn't exist, this function will do nothing.
/// 
/// @param name
/// @param variableName
/// @param value
/// @param [environmentOrName=current]

function BentoNameSetVar(_name, _variableName, _value, _environmentOrName = undefined)
{
    var _element = BentoNameFind(_name, _environmentOrName);
    if (not BentoExists(_element)) return;
    
    _element[$ _variableName] = _value;
}