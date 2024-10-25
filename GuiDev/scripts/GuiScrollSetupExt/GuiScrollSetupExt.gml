// Feather disable all

/// Sets up the minimum and maximum scroll offsets that are allowed.
/// 
/// N.B. This function doesn't set up a scissor region so all child instances will be visible
///      by default regardless of position.
/// 
/// @param minX
/// @param minY
/// @param maxX
/// @param maxY
/// @param [instance=id]

function GuiScrollSetupExt(_minX, _minY, _maxX, _maxY, _instance = id)
{
    with(_instance)
    {
        __scrollEnabled = true;
        
        __GuiSetIfNotDefined(_instance, "__scrollX", 0);
        __GuiSetIfNotDefined(_instance, "__scrollY", 0);
        
        __scrollX = clamp(__scrollX, _minX, _maxX);
        __scrollY = clamp(__scrollY, _minY, _maxY);
        
        __scrollMinX = _minX;
        __scrollMinY = _minY;
        __scrollMaxX = _maxX;
        __scrollMaxY = _maxY;
    }
}