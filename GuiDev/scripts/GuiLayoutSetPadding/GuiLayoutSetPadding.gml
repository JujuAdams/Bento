// Feather disable all

/// @param [left]
/// @param [top]
/// @param [right]
/// @param [bottom]
/// @param [instance=id]

function GuiLayoutSetPadding(_left, _top, _right, _bottom, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    if (not variable_instance_exists(_instance, "__layoutPadLeft"))
    {
        __GuiError("Can only set list padding on objects that inherit from `oGuiLibList` or `oGuiLibGrid`");
    }
    
    with(_instance.__gui)
    {
        if (_left != undefined)
        {
            if (__layoutPadLeft != _left)
            {
                __layoutPadLeft = _left;
                _system.__layoutDirty = true;
            }
        }
        
        if (_top != undefined)
        {
            if (__layoutPadTop != _top)
            {
                __layoutPadTop = _top;
                _system.__layoutDirty = true;
            }
        }
        
        if (_right != undefined)
        {
            if (__layoutPadRight != _right)
            {
                __layoutPadRight = _right;
                _system.__layoutDirty = true;
            }
        }
        
        if (_bottom != undefined)
        {
            if (__layoutPadBottom != _bottom)
            {
                __layoutPadBottom = _bottom;
                _system.__layoutDirty = true;
            }
        }
    }
}