// Feather disable all

/// Returns a struct that contains four variables: `.left` `.top` `.right` `.bottom`. These
/// variables contain the x/y coordinates of the axis-aligned bounding box for the last element
/// that was hovered.
/// 
/// N.B. This function will still return valid coordinates even if the last element has been
///      destroyed or is unhoverable. Typically, you should check if there is a valid element being
///      hovered before doing anything with these coordinates .
/// 
/// @param [layerOrName=current]

function BentoCursorGetBox(_layerOrName = undefined)
{
    static _result = {};
    
    var _layer = __BentoLayerEnsure(_layerOrName);
    if (_layer == undefined)
    {
        with(_layer)
        {
            _result.left   = __cursorLastL;
            _result.top    = __cursorLastT;
            _result.right  = __cursorLastR;
            _result.bottom = __cursorLastB;
        }
    }
    else
    {
        with(_result)
        {
            left   = 0;
            top    = 0;
            right  = 0;
            bottom = 0;
        }
    }
    
    return _result;
}