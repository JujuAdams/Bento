// Feather disable all

/// Sets the name of an instance. If `overwrite` is set to `false` then a naming conflict will
/// cause this function to throw an error. If `overwrite` is set to `true` then the instance with
/// a matching name will have its name removed.
/// 
/// @param name
/// @param [instance=self]
/// @param [overwrite=false]

function GuiNameSet(_name, _instance = self, _overwrite = false)
{
    if (not GUI_EXISTS(_instance)) return;
    
    var _nameMap = _instance.GUI_VARS.__environment.__nameMap;
    
    var _oldInstance = _nameMap[? _name];
    if ((_oldInstance != undefined) && GUI_EXISTS(_oldInstance))
    {
        if (_overwrite)
        {
            _oldInstance.GUI_VARS.__name = undefined;
        }
        else
        {
            __GuiError($"Instance with name \"{_name}\" already exists (UI element {_oldInstance.GUI_VARS.__globalIndex} {object_get_name(_oldInstance.object_index)})");
        }
    }
    
    _nameMap[? _name] = _instance;
    _instance.GUI_VARS.__name = _name;
}