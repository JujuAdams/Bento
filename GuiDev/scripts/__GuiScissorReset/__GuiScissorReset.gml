// Feather disable all

/// Completely resets the draw event scissor stack. This will set GPU state.

function __GuiScissorReset()
{
    static _scissorStack = __GuiSystem().__scissorStack;
    
    array_resize(_scissorStack, 0);
    array_push(_scissorStack, gpu_get_scissor());
    
    return _scissorStack;
}