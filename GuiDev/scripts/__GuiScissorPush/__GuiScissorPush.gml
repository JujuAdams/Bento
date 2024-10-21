// Feather disable all

/// Pushes an entry to the draw event scissor stack. This will set GPU state.
/// 
/// @param left
/// @param top
/// @param right
/// @param bottom

function __GuiScissorPush(_newL, _newT, _newR, _newB)
{
    static _scissorStack = __GuiSystem().__scissorStack;
    
    var _currentScissor = _scissorStack[array_length(_scissorStack)-1];
    
    var _l = _currentScissor.x;
    var _t = _currentScissor.y;
    var _r = _l + _currentScissor.w;
    var _b = _t + _currentScissor.h;
    
    _l = max(_l, _newL);
    _t = max(_t, _newT);
    _r = min(_r, _newR);
    _b = min(_b, _newB);
    
    array_push(_scissorStack, {
        x: _l,
        y: _t,
        w: _r - _l,
        h: _b - _t,
    });
    
    __GuiScissorSet(_l, _t, _r - _l, _b - _t);
}