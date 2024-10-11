// Feather disable all

/// @param child

function __GuiScrollFindParent(_child)
{
    if (not instance_exists(_child)) return noone;
    if (_child.__scroll) return _child;
    
    return (_child.__inside? __GuiScrollFindParent(_child.__parent) : noone);
}