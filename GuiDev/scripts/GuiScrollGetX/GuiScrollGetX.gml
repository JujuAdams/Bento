// Feather disable all

/// Returns the current scroll x-offset.
/// 
/// @param [instance=id]

function GuiScrollGetX(_instance = id)
{
    if (not instance_exists(_instance)) return 0;
    
    return _instance.__scrollX;
}