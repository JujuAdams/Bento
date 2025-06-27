// Feather disable all

/// @param parent

function __BentoMarkDrawOrderDirty(_parent)
{
    if (not BentoExists(_parent)) return;
    
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