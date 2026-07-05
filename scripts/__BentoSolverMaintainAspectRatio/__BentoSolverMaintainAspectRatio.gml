// Feather disable all

function __BentoSolverMaintainAspectRatio()
{
    if (__layoutHeightResize == BENTO_RESIZE_ASPECT)
    {
        var _aspect = __BentoSolvertGetSafeWidth() / __BentoSolvertGetSafeHeight();
        
        var _newHeight = __solvedWidth / _aspect;
        if (_newHeight == clamp(_newHeight,
                                __BentoParsePercentageString(__layoutHeightMin, display_get_gui_height()),
                                __BentoParsePercentageString(__layoutHeightMax, display_get_gui_height())))
        {
            __solvedHeight = _newHeight;
        }
        else
        {
            var _newWidth = __solvedHeight * _aspect;
            if (_newWidth == clamp(_newWidth,
                                   __BentoParsePercentageString(__layoutWidthMin, display_get_gui_width()),
                                   __BentoParsePercentageString(__layoutWidthMax, display_get_gui_width())))
            {
                __solvedWidth = _newWidth;
            }
        }
    }
}