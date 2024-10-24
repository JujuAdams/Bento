// Feather disable all

/// Convenience function to set up a horizontal scroll region based on the position of child
/// instances "inside" the parent.
/// 
/// @param [paddingLeft=0]
/// @param [paddingRight=0]
/// @param [instance=id]

function GuiScrollSetupHori(_paddingLeft = 0, _paddingRight = 0, _instance = id)
{
    with(_instance)
    {
        if (not __scissorState)
        {
            __GuiError("Scissor region not set up");
        }
        
        var _visibleWidth = __scissorRight - __scissorLeft;
        
        var _bounds = GuiGetChildrenBoundsInside();
        var _childrenWidth = _bounds.width;
        
        if (_childrenWidth <= _visibleWidth - (_paddingLeft + _paddingRight))
        {
            var _scrollWidth = (_childrenWidth - _visibleWidth) + _paddingRight;
            var _dX = _bounds.left - __scissorRight;
            
            GuiScrollSetupExt(-_scrollWidth, 0, _paddingLeft + _dX, 0);
            __scrollX = _dX;
            GuiScrollSet(_paddingLeft + _dX, 0);
        }
    }
}