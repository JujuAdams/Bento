// Feather disable all

/// Returns the current scroll y-offset.
/// 
/// @param [instance=self]

function GuiScrollGetY(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return 0;
    
    return _instance.GUI_VARS.__scrollY;
}