// Feather disable all

/// Manually moves the scroll offset.
/// 
/// @param [dX=0]
/// @param [dY=0]
/// @param [scrollSpeed]
/// @param [instance=id]

function GuiScrollMoveLocal(_dX = 0, _dY = 0, _scrollSpeed = GUI_DEFAULT_SCROLL_SPEED, _instance = id)
{
    var _parent = __GuiScrollFindParent(_instance);
    if (not instance_exists(_parent)) return;
    
    GuiScrollSet(_parent.__scrollX + _dX, _parent.__scrollY + _dY, _scrollSpeed, _parent);
}