// Feather disable all

/// @param instance
/// @param name
/// @param [overwrite=false]

function GuiSetName(_instance, _name, _overwrite = false)
{
    static _nameMap = __GuiSystem().__nameMap;
    
    if (not _overwrite)
    {
        var _oldInstance = _nameMap[? _name];
        if ((_oldInstance != undefined) && instance_exists(_oldInstance))
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