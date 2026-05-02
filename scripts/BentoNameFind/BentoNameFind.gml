// Feather disable all

/// Returns the element with a matching name. If no such element exists, this function will return
/// `BENTO_NO_ELEMENT`.
/// 
/// @param name
/// @param [environmentOrName=current]

function BentoNameFind(_name, _environmentOrName = undefined)
{
    var _environment = __BentoEnvironmentEnsure(_environmentOrName);
    if (_environment != undefined)
    {
        return (_environment.__nameMap[? _name] ?? BENTO_NO_ELEMENT);
    }
    else
    {
        return BENTO_NO_ELEMENT;
    }
}