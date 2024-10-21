// Feather disable all

/// Finds the nearest scrollable ancestor up the hierarchy.
/// 
/// @param child

function __GuiScrollFindParent(_child)
{
    if (not instance_exists(_child)) return noone;
    if (_child.__scrollEnabled) return _child;
    
    return (_child.__inside? __GuiScrollFindParent(_child.__parent) : noone);
}