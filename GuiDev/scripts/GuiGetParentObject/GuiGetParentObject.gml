// Feather disable all

/// Returns the first ancestor in the hierarchy that is an instance of a particular object. If no
/// such ancestor can be found, this function returns `noone`.
/// 
/// @param object
/// @param [instance=id]

function GuiGetParentObject(_object, _instance = id)
{
    if (not instance_exists(_instance)) return noone;
    
    if (_instance.object_index == _object) return _instance;
    
    return GuiGetParentObject(_object, _instance.__parent);
}