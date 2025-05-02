// Feather disable all

/// Returns whether the cursor is over the instance.
/// 
/// @param [instance]

function GuiNavGetOver(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return false;
    return ((_instance.GUI_VARS.__overState == GUI_ENTER) || (_instance.GUI_VARS.__overState == GUI_OVER));
}