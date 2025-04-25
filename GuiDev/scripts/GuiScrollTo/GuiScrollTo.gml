// Feather disable all

/// Scrolls to highlight an instance inside a parent.
/// 
/// @param [scrollSpeed]
/// @param [instance=id]

function GuiScrollTo(_scrollSpeed = GUI_DEFAULT_SCROLL_SPEED, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    var _result = __GuiGetScrollDelta(_instance);
    if (not instance_exists(_result.__parent)) return;
    
    GuiScrollMove(_result.__dX, _result.__dY, _scrollSpeed, _result.__parent);
}