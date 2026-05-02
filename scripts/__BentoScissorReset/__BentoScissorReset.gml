// Feather disable all

/// Completely resets the draw event scissor stack. This will set GPU state.

function __BentoScissorReset()
{
    static _system = __BentoSystem();
    
    with(_system)
    {
        var _scissor = gpu_get_scissor();
        
        //Convert screen-space coordinates into Bento-space
        _scissor.x  = (_scissor.x - __globalScissorXOffset) / __globalScissorXScale;
        _scissor.y  = (_scissor.y - __globalScissorYOffset) / __globalScissorYScale;
        _scissor.w /= __globalScissorXScale;
        _scissor.h /= __globalScissorYScale;
        
        array_resize(__scissorStack, 0);
        array_push(__scissorStack, _scissor);
        
        return __scissorStack;
    }
}