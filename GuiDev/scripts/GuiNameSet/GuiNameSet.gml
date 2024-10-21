// Feather disable all

/// Sets the name of an instance. If `overwrite` is set to `false` then a naming conflict will
/// cause this function to throw an error. If `overwrite` is set to `true` then the instance with
/// a matching name will have its name removed.
/// 
/// @param name
/// @param [instance=id]
/// @param [overwrite=false]

function GuiNameSet(_name, _instance = id, _overwrite = false)
{
    static _nameMap = __GuiSystem().__nameMap;
    
    var _oldInstance = _nameMap[? _name];
    if ((_oldInstance != undefined) && instance_exists(_oldInstance))
    {
        if (_overwrite)
        {
            _oldInstance.__name = undefined;
        }
        else
        {
            __GuiError($"Instance with name \"{_name}\" already exists (id={_oldInstance.id}, type={_oldInstance.object_index})");
        }
    }
    
    if (not instance_exists(_instance))
    {
        if (_overwrite)
        {
            ds_map_delete(_nameMap, _name);
        }
        
        return;
    }
    
    _nameMap[? _name] = _instance;
    _instance.__name = _name;
}