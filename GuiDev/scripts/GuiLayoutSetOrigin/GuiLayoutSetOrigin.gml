// Feather disable all

/// @param x
/// @param y
/// @param [instance=id]
/// @param [proportional=true]

function GuiLayoutSetOrigin(_x, _y, _instance = id, _proportional = true)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (__layoutOriginX != _x)
        {
            __layoutOriginX = _x;
            __environment.__layoutDirty = true;
        }
        
        if (__layoutOriginY != _y)
        {
            __layoutOriginY = _y;
            __environment.__layoutDirty = true;
        }
        
        if (__layoutOriginProp != _proportional)
        {
            __layoutOriginProp = _proportional;
            __environment.__layoutDirty = true;
        }
    }
}