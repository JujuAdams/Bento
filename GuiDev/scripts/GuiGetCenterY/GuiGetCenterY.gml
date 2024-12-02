// Feather disable all

/// Returns the y-coordinate of the center of the instance.
/// 
/// @param [instance=id]

function GuiGetCenterY(_instance = id)
{
    return 0.5*(_instance.bbox_top + _instance.bbox_bottom);
}