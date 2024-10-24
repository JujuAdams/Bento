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
        var _bounds = GuiGetChildrenBoundsInside();
        var _childrenLeft  = _bounds.left;
        var _childrenWidth = _bounds.width;
        
        if (_childrenWidth <= width - (_paddingLeft + _paddingRight))
        {
            GuiScrollSetupExt(_paddingLeft, 0, _paddingLeft, 0);
            GuiScrollSet(_paddingLeft, 0);
        }
        else
        {
            var _min = (width - _paddingRight) - _childrenWidth;
            
            var _dX = _childrenLeft - (x - width/2);
            
            GuiScrollSetupExt(_min, 0, _paddingLeft + _dX, 0);
            __scrollX = _dX;
            GuiScrollSet(_paddingLeft + _dX, 0);
        }
    }
}