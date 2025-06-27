// Feather disable all

/// Returns the y-coordinate of the cursor's position.
/// 
/// @param [layer=current]

function BentoCursorGetBox(_layer = undefined)
{
    static _system = __BentoSystem();
    static _result = {};
    
    with(_result)
    {
        left   = 0;
        top    = 0;
        right  = 0;
        bottom = 0;
    }
    
    with(_layer ?? _system.__layerCurrent)
    {
        _result.left   = __cursorLastL;
        _result.top    = __cursorLastT;
        _result.right  = __cursorLastR;
        _result.bottom = __cursorLastB;
    }
    
    return _result;
}