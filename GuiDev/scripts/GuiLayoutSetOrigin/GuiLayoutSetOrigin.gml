// Feather disable all

/// @param x
/// @param y
/// @param [instance=id]
/// @param [proportional=true]

function GuiLayoutSetOrigin(_x, _y, _instance = id, _proportional = true)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (__layoutOriginX != _x)
        {
            __layoutOriginX = _x;
            _system.__layoutDirty = true;
        }
        
        if (__layoutOriginY != _y)
        {
            __layoutOriginY = _y;
            _system.__layoutDirty = true;
        }
        
        if (__layoutOriginProp != _proportional)
        {
            __layoutOriginProp = _proportional;
            _system.__layoutDirty = true;
        }
    }
}