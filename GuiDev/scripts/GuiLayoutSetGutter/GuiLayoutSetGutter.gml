// Feather disable all

/// @param [x]
/// @param [y]
/// @param [instance=id]

function GuiLayoutSetGutter(_x, _y, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
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
                _system.__layoutDirty = true;
            }
        }
        
        if (_y != undefined)
        {
            if (__layoutGutterY != _y)
            {
                __layoutGutterY = _y;
                _system.__layoutDirty = true;
            }
        }
    }
}