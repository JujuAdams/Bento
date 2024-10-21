// Feather disable all

/// Manually moves the scroll offset.
/// 
/// @param [dX=0]
/// @param [dY=0]
/// @param [instance=id]

function GuiScrollMove(_dX = 0, _dY = 0, _instance = id)
{
    var _parent = __GuiScrollFindParent(_instance);
    if (not instance_exists(_parent)) return noone;
    
    GuiScrollSet(_parent.__scrollX + _dX, _parent.__scrollY + _dY, _parent);
    
    return _parent;
}