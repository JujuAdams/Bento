// Feather disable all

/// Returns the current scroll y-offset.
/// 
/// @param [instance=id]

function GuiScrollGetY(_instance = id)
{
    if (not instance_exists(_instance)) return 0;
    
    return _instance.__scrollY;
}