// Feather disable all

/// Temporarily disables GPU scissoring.
/// 
/// N.B. This function should only be used in a Draw user event (`BENTO_USER_EVENT_DRAW`). You also
///      be careful to guarantee `BentoClipDrawOn()` is called to turn scissoring back on.

function BentoClipDrawOff()
{
    static _scissorStack = __BentoSystem().__scissorStack;
    
    //If we only have one scissor on the stack then we don't need to set the GPU state
    if (array_length(_scissorStack) <= 1) return;
    
    var _struct = _scissorStack[0];
    __BentoScissorSetGPU(_struct.x, _struct.y, _struct.w, _struct.h);
}