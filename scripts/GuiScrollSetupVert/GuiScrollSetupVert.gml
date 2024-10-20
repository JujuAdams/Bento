// Feather disable all

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
        
        GuiScrollSetupExt(id, 0, _min, 0, _paddingTop);
        GuiScrollSet(0, _paddingTop, id);
    }
}