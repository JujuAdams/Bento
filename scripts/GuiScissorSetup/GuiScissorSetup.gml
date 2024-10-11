// Feather disable all

/// @param instance
/// @param left
/// @param top
/// @param right
/// @param bottom

function GuiScissorSetup(_instance, _left, _top, _right, _bottom)
{
    static _system = __GuiSystem();
    
    _system.__stepDirty = true;
    _system.__drawDirty = true;
    
    with(_instance)
    {
        __scissorState = true;
        
        __scissorLeft   = _left;
        __scissorTop    = _top;
        __scissorRight  = _right;
        __scissorBottom = _bottom;
    }
}