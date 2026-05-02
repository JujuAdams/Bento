// Feather disable all

/// Pops an entry off of the draw event scissor stack. This will set GPU state.

function __BentoDrawScissorPop()
{
    static _scissorStack = __BentoSystem().__scissorStack;
    
    var _hoverElement = __layer.__hoverElement;
    if (BentoExists(_hoverElement))
    {
        var _hoverElementVars = _hoverElement.BENTO_VARS;
        if (_hoverElementVars.__scissorParent == self)
        {
            _hoverElementVars.__eventDrawHover();
        }
    }
    
    array_pop(_scissorStack);
    var _scissor = _scissorStack[array_length(_scissorStack)-1];
    __BentoScissorSetGPU(_scissor.x, _scissor.y, _scissor.w, _scissor.h);
}