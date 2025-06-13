// Feather disable all

/// @param [maxDuration=10s]
/// @param [element=self]

function GuiAnimStart(_maxDuration = 10_000, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS.__layer)
    {
        if (ds_map_exists(__animatingMap, _element))
        {
            array_push(__animatingArray, {
                __element: _element,
                __timeout: current_time + _maxDuration,
            });
        }
        
        __animatingMap[? _element] = true;
    }
}