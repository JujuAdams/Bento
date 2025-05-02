// Feather disable all

/// Returns the current scroll x-offset.
/// 
/// @param [instance=self]

function GuiScrollGetX(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return 0;
    
    return _instance.GUI_VARS.__scrollX;
}