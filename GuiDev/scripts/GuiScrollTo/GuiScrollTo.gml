// Feather disable all

/// Scrolls to highlight an instance inside a parent.
/// 
/// @param [scrollSpeed]
/// @param [instance=self]

function GuiScrollTo(_scrollSpeed = GUI_DEFAULT_SCROLL_SPEED, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    var _result = __GuiGetScrollDelta(_instance);
    if (not GUI_EXISTS(_result.__parent)) return;
    
    GuiScrollMove(_result.__dX, _result.__dY, _scrollSpeed, _result.__parent);
}