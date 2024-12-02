// Feather disable all

/// Returns the x-coordinate of the center of the instance.
/// 
/// @param [instance=id]

function GuiGetCenterX(_instance = id)
{
    return 0.5*(_instance.bbox_left + _instance.bbox_right);
}