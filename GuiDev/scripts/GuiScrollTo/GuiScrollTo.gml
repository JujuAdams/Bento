// Feather disable all

/// Scrolls to highlight an instance inside a parent.
/// 
/// @param [scrollSpeed]
/// @param [element=self]

function GuiScrollTo(_scrollSpeed = GUI_DEFAULT_SCROLL_SPEED, _element = self)
{
    if (not __GuiExists(_element)) return;
    
    var _result = __GuiGetScrollDelta(_element);
    if (not __GuiExists(_result.__parent)) return;
    
    GuiScrollMove(_result.__dX, _result.__dY, _scrollSpeed, _result.__parent);
}