// Feather disable all

/// Manually moves the scroll offset.
/// 
/// @param [dX=0]
/// @param [dY=0]
/// @param [scrollSpeed]
/// @param [element=self]

function GuiScrollMove(_dX = 0, _dY = 0, _scrollSpeed = GUI_DEFAULT_SCROLL_SPEED, _element = self)
{
    var _scroller = __GuiScrollFindParent(_element);
    if (not __GuiExists(_scroller)) return;
    
    GuiScrollSet(_scroller.GUI_VARS.__scrollX + _dX, _scroller.GUI_VARS.__scrollY + _dY, _scrollSpeed, _scroller);
}