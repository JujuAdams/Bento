// Feather disable all

/// Returns the current scroll x-offset target.
/// 
/// @param [instance=id]

function GuiScrollGetTargetX(_instance = id)
{
    if (not instance_exists(_instance)) return 0;
    
    return _instance.GUI_STRUCT.__scrollTargetX;
}