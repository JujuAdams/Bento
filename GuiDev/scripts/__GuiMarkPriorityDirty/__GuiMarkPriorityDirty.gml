// Feather disable all

/// @param parent

function __GuiMarkChildOrderDirty(_parent)
{
    if (not GUI_EXISTS(_parent)) return;
    
    with(_parent.GUI_VARS)
    {
        if (not __childOrderDirty)
        {
            __childOrderDirty = true;
            array_push(__environment.__dirtyChildOrderArray, _parent);
        }
    }
}