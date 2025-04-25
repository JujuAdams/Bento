// Feather disable all

/// Sorts children in priority order.
/// 
/// @param parent

function __GuiSortChildren(_parent)
{
    static _funcSort = function(_a, _b)
    {
        var _delta = (_a.__gui.__priority - _b.__gui.__priority);
        
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
    }
    
    with(_parent)
    {
        if (not __childOrderDirty) return;
        __childOrderDirty = false;
        
        array_sort(__childArray, _funcSort);
    }
}