// Feather disable all

/// @param [left]
/// @param [top]
/// @param [right]
/// @param [bottom]
/// @param [instance=id]

function GuiSetLayoutPadding(_left, _top, _right, _bottom, _instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (not variable_instance_exists(id, "__layoutPadLeft"))
        {
            __GuiError("Can only set list padding on objects that inherit from `oGuiLibList` or `oGuiLibGrid`");
        }
        
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