// Feather disable all

/// @param instance
/// @param minX
/// @param minY
/// @param maxX
/// @param maxY

function GuiScrollSetupExt(_instance, _minX, _minY, _maxX, _maxY)
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