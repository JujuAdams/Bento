// Feather disable all

/// Convenience function to set up a vertical scroll region based on the position of child
/// instances "inside" the parent.
/// 
/// N.B. This function doesn't set up a scissor region so all child instances will be visible
///      by default regardless of position. Please call `GuiScissorSetup()` to set up scissoring. 
/// 
/// @param [paddingTop=0]
/// @param [paddingBottom=0]
/// @param [instance=id]

function GuiScrollSetupVert(_paddingTop = 0, _paddingBottom = 0, _instance = id)
{
    with(_instance)
    {
        var _childrenHeight = GuiGetChildrenBounds().height;
        if (_childrenHeight <= height - (_paddingTop + _paddingBottom))
        {
            var _min = _paddingTop;
        }
        else
        {
            var _min = (height - _paddingBottom) - _childrenHeight;
        }
        
        GuiScrollSetupExt(0, _min, 0, _paddingTop);
        GuiScrollSet(0, _paddingTop);
    }
}