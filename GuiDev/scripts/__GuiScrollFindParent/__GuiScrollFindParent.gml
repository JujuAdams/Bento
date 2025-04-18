// Feather disable all

/// Finds the nearest scrollable ancestor up the hierarchy.
/// 
/// @param instance

function __GuiScrollFindParent(_instance)
{
    if (not instance_exists(_instance)) return noone;
    if (_instance.__scrollHori || _instance.__scrollVert) return _instance;
    
    return __GuiScrollFindParent(_instance.__parent);
}