// Feather disable all

function __GuiScissorPop()
{
    static _scissorStack = __GuiSystem().__scissorStack;
    
    array_pop(_scissorStack);
    var _scissor = _scissorStack[array_length(_scissorStack)-1];
    __GuiScissorSet(_scissor.x, _scissor.y, _scissor.w, _scissor.h);
}