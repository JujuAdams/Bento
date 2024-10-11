// Feather disable all

/// @param instance
/// @param [maxX=0]
/// @param [maxY=0]
/// @param [minX=0]
/// @param [minY=0]

function GuiScrollSetup(_instance, _maxX = 0, _maxY = 0, _minX = 0, _minY = 0)
{
    with(_instance)
    {
        __scroll = true;
        
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