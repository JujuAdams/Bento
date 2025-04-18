// Feather disable all

/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [instance=id]

function GuiScissorSetPadding(_left, _top, _right, _bottom, _instance = id)
{
    static _system = __GuiSystem();
    
    _system.__stepDirty = true;
    _system.__drawDirty = true;
    
    with(_instance)
    {
        __scissorPadLeft   = _left;
        __scissorPadTop    = _top;
        __scissorPadRight  = _right;
        __scissorPadBottom = _bottom;
    }
}