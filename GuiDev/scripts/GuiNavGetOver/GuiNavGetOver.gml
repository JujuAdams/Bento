// Feather disable all

/// Returns whether the cursor is over the instance.
/// 
/// @param [instance]

function GuiNavGetOver(_element = self)
{
    if (not GUI_EXISTS(_element)) return false;
    return ((_element.GUI_VARS.__overState == GUI_ENTER) || (_element.GUI_VARS.__overState == GUI_OVER));
}