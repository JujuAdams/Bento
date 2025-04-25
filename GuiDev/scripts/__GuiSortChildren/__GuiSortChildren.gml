// Feather disable all

/// Sorts children in priority order.
/// 
/// @param parent

function __GuiSortChildren(_parent)
{
    with(_parent.GUI_STRUCT)
    {
        if (not __childOrderDirty) return;
        __childOrderDirty = false;
        
        array_sort(__childArray, function(_a, _b)
        {
            var _delta = (_a.GUI_STRUCT.__priority - _b.GUI_STRUCT.__priority);
            
            if (_delta > 0)
            {
                return 1;
            }
            else if (_delta < 0)
            {
                return -1;
            }
            else
            {
                return sign(real(_a.id) - real(_b.id));
            }
        });
    }
}