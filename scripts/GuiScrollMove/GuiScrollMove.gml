// Feather disable all

/// @param instance
/// @param [dX=0]
/// @param [dY=0]

function GuiScrollMove(_instance, _dX = 0, _dY = 0)
{
    var _parent = __GuiScrollFindParent(_instance);
    if (not instance_exists(_parent)) return noone;
    
    GuiScrollSet(_parent, _parent.__scrollX + _dX, _parent.__scrollY + _dY);
    
    return _parent;
}