// Feather disable all

/// Must be called in the scope of `__GuiClassEnvironment`.

function __GuiEnsureChildOrder()
{
    static _funcForEach = function(_instance)
    {
        static _funcSort = function(_a, _b)
        {
            var _delta = (_a.GUI_VARS.__priority - _b.GUI_VARS.__priority);
            
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
        
        with(_instance.GUI_VARS)
        {
            if (__childOrderDirty)
            {
                __childOrderDirty = false;
                array_sort(__childArray, _funcSort);
            }
        }
    }
    
    array_foreach(__dirtyChildOrderArray, _funcForEach);
    array_resize(__dirtyChildOrderArray, 0);
}