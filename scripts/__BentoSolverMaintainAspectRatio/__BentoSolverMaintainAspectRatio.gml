// Feather disable all

function __BentoSolverMaintainAspectRatio()
{
    if (__layoutHeightResize == BENTO_RESIZE_ASPECT)
    {
        var _aspect = __BentoSolvertGetSafeWidth() / __BentoSolvertGetSafeHeight();
        
        var _newHeight = __solvedWidth / _aspect;
        if (_newHeight == clamp(_newHeight, __layoutHeightMin, __layoutHeightMax))
        {
            __solvedHeight = _newHeight;
        }
        else
        {
            var _newWidth = __solvedHeight * _aspect;
            if (_newWidth == clamp(_newWidth, __layoutWidthMin, __layoutWidthMax))
            {
                __solvedWidth = _newWidth;
            }
        }
    }
}