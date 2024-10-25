// Feather disable all

/// Re-enables GPU scissoring after temporarily disabling it with `GuiScrollClipOff()`.

function GuiScrollClipOn()
{
    static _scissorStack = __GuiSystem().__scissorStack;
    
    //If we only have one scissor on the stack then we don't need to set the GPU state
    if (array_length(_scissorStack) <= 1) return;
    
    var _struct = _scissorStack[array_length(_scissorStack)-1];
    __GuiScissorSet(_struct.x, _struct.y, _struct.w, _struct.h);
}