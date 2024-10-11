// Feather disable all

/// @param parent

function __GuiSortChildren(_parent)
{
    static _funcSort = function(_a, _b)
    {
        if (_a.priority > _b.priority)
        {
            return 1;
        }
        else if (_a.priority < _b.priority)
        {
            return -1;
        }
        else
        {
            return sign(_a.__guiIndex - _b.__guiIndex);
        }
    }
    
    with(_parent)
    {
        if (not __orderDirty) return;
        __orderDirty = false;
        
        array_sort(__childInsideArray,  _funcSort);
        array_sort(__childOutsideArray, _funcSort);
    }
}