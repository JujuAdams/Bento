// Feather disable all

/// Finds the nearest scrollable ancestor up the hierarchy.
/// 
/// @param instance

function __GuiScrollFindParent(_instance)
{
    if (not instance_exists(_instance)) return noone;
    
    var _gui = _instance.GUI_STRUCT;
    if (_gui.__scrollHori || _gui.__scrollVert) return _instance;
    
    return __GuiScrollFindParent(_gui.__parent);
}