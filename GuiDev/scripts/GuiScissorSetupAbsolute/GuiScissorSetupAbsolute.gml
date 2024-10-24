// Feather disable all

/// Sets up scissoring for an instance. Child instances that are "inside" the parent will have
/// their graphics clipped inside parent instance. The padding parameters allows you to make the
/// scissor region smaller than the parent's bounding box.
/// 
/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [instance=id]

function GuiScissorSetupAbsolute(_left, _top, _right, _bottom, _instance = id)
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