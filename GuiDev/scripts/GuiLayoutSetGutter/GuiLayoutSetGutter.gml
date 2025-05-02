// Feather disable all

/// @param [x]
/// @param [y]
/// @param [instance=self]

function GuiLayoutSetGutter(_x, _y, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (not variable_struct_exists(self, "__layoutGutterX"))
        {
            __GuiError("Can only set list gutters on objects that inherit from `oGuiLibList` or `oGuiLibGrid`");
        }
        
        if (_x != undefined)
        {
            if (__layoutGutterX != _x)
            {
                __layoutGutterX = _x;
                __environment.__layoutDirty = true;
            }
        }
        
        if (_y != undefined)
        {
            if (__layoutGutterY != _y)
            {
                __layoutGutterY = _y;
                __environment.__layoutDirty = true;
            }
        }
    }
}