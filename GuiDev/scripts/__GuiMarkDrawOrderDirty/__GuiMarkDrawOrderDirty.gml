// Feather disable all

/// @param parent

function __GuiMarkDrawOrderDirty(_parent)
{
    if (not GuiExists(_parent)) return;
    
    with(_parent.GUI_VARS)
    {
        if (not __drawOrderDirty)
        {
            __drawOrderDirty = true;
            array_push(__layer.__dirtyChildOrderArray, _parent);
            
            __layer.__dirtyFlags |= __GUI_DIRTY_DRAW;
        }
    }
}