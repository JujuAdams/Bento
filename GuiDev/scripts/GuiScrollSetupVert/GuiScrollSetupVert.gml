// Feather disable all

/// Convenience function to set up a vertical scroll region based on the position of child
/// instances "inside" the parent. 
/// 
/// @param [paddingTop=0]
/// @param [paddingBottom=0]
/// @param [instance=id]

function GuiScrollSetupVert(_paddingTop = 0, _paddingBottom = 0, _instance = id)
{
    with(_instance)
    {
        if (not __scissorState)
        {
            __GuiError("Scissor region not set up");
        }
        
        var _visibleHeight = __scissorBottom - __scissorTop;
        
        var _bounds = GuiGetChildrenBoundsInside();
        var _childrenHeight = _bounds.height;
        
        if (_childrenHeight > _visibleHeight - (_paddingTop + _paddingBottom))
        {
            var _scrollHeight = (_childrenHeight - _visibleHeight) + _paddingBottom;
            var _dY = _bounds.top - __scissorTop;
            
            GuiScrollSetupExt(0, -_scrollHeight, 0, _paddingTop + _dY);
            __scrollY = _dY;
            GuiScrollSet(0, _paddingTop + _dY);
        }
    }
}