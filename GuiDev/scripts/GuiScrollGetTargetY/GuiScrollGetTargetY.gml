// Feather disable all

/// Returns the current scroll y-offset target.
/// 
/// @param [instance=self]

function GuiScrollGetTargetY(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return 0;
    
    return _instance.GUI_VARS.__scrollTargetY;
}