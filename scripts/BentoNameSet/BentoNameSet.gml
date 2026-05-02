// Feather disable all

/// Sets the name of an element. If `overwrite` is set to `false` then a naming conflict will
/// cause this function to throw an error. If `overwrite` is set to `true` then the existing
/// named element will have its name removed.
/// 
/// @param name
/// @param [element=self]
/// @param [overwrite=true]

function BentoNameSet(_name, _element = self, _overwrite = true)
{
    if (not BentoExists(_element)) return;
    
    var _nameMap = _element.BENTO_VARS.__layer.__environment.__nameMap;
    
    var _oldElement = _nameMap[? _name];
    if ((_oldElement != undefined) && BentoExists(_oldElement))
    {
        if (_overwrite)
        {
            _oldElement.BENTO_VARS.__name = undefined;
        }
        else
        {
            __BentoError($"Element with name \"{_name}\" already exists (element {_oldElement.BENTO_VARS.__envIndex} {object_get_name(_oldElement.object_index)})");
        }
    }
    
    _nameMap[? _name] = _element;
    _element.BENTO_VARS.__name = _name;
}