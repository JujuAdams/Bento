// Feather disable all

/// Returns the first ancestor in the hierarchy that is an instance of a particular object. If no
/// such ancestor can be found, this function returns `noone`.
/// 
/// @param object
/// @param [instance=self]

function GuiGetParentObject(_object, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return noone;
    
    if (_instance.object_index == _object) return _instance;
    
    return GuiGetParentObject(_object, _instance.GUI_VARS.__parent);
}