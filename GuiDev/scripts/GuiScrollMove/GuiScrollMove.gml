// Feather disable all

/// Manually moves the scroll offset.
/// 
/// @param [dX=0]
/// @param [dY=0]
/// @param [scrollSpeed]
/// @param [instance=id]

function GuiScrollMove(_dX = 0, _dY = 0, _scrollSpeed = GUI_DEFAULT_SCROLL_SPEED, _instance = id)
{
    var _scroller = __GuiScrollFindParent(_instance);
    if (not instance_exists(_scroller)) return;
    
    GuiScrollSet(_scroller.GUI_STRUCT.__scrollX + _dX, _scroller.GUI_STRUCT.__scrollY + _dY, _scrollSpeed, _scroller);
}