// Feather disable all

/// @param object
/// @param [instance=id]

function GuiGetParentObject(_object, _instance = id)
{
    if (not instance_exists(_instance)) return noone;
    
    if (_instance.object_index == _object) return _instance;
    
    return GuiGetParentObject(_object, _instance.__parent);
}