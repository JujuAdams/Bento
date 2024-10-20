// Feather disable all

/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [instance=id]

function GuiScissorSetupExt(_left, _top, _right, _bottom, _instance = id)
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