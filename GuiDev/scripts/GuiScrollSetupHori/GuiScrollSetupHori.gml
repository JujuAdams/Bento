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
        var _width = max(0, GuiGetChildrenBounds().width - width);
        if (_width > -_paddingLeft) _width += _paddingRight;
        
        GuiScrollSetupExt(-_width, 0, _paddingLeft, 0);
        GuiScrollSet(_paddingLeft, 0);
    }
}