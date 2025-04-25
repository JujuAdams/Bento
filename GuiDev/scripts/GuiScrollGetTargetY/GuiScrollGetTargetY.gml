// Feather disable all

/// Returns the current scroll y-offset target.
/// 
/// @param [instance=id]

function GuiScrollGetTargetY(_instance = id)
{
    if (not instance_exists(_instance)) return 0;
    
    return _instance.GUI_STRUCT.__scrollTargetY;
}