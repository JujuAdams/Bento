// Feather disable all

function __BentoSolverMaintainAspectRatio(_rootWidth, _rootHeight)
{
    static _system = __BentoSystem();
    
    if (__layoutHeightResize == BENTO_RESIZE_ASPECT)
    {
        var _aspect = __BentoSolverGetSafeWidth(_rootWidth) / __BentoSolverGetSafeHeight(_rootHeight);
        
        var _newHeight = __solvedWidth / _aspect;
        if (_newHeight == clamp(_newHeight,
                                __BentoParsePercentageString(__layoutHeightMin, _rootHeight),
                                __BentoParsePercentageString(__layoutHeightMax, _rootHeight)))
        {
            __solvedHeight = _newHeight;
        }
        else
        {
            var _newWidth = __solvedHeight * _aspect;
            if (_newWidth == clamp(_newWidth,
                                   __BentoParsePercentageString(__layoutWidthMin, _rootWidth),
                                   __BentoParsePercentageString(__layoutWidthMax, _rootWidth)))
            {
                __solvedWidth = _newWidth;
            }
        }
    }
}