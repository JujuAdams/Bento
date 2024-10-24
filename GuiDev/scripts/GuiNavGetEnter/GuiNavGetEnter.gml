// Feather disable all

/// Returns whether the cursor has entered (newly hovered) the instance.
/// 
/// @param [instance=id]

function GuiNavGetEnter(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    return (_instance.__overState == GUI_ENTER);
}