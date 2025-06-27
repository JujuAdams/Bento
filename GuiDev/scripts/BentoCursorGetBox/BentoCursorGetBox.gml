// Feather disable all

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