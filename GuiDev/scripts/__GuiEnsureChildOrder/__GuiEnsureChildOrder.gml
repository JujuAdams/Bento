// Feather disable all

/// Must be called in the scope of `__GuiClassLayer`.

function __GuiEnsureChildOrder()
{
    static _funcForEach = function(_element)
    {
        static _funcSort = function(_a, _b)
        {
            _a = _a.GUI_VARS;
            _b = _b.GUI_VARS;
            
            var _delta = (_a.__priority - _b.__priority);
            
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
                return sign(_a.__envIndex - _b.__envIndex);
            }
        }
        
        with(_element.GUI_VARS)
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