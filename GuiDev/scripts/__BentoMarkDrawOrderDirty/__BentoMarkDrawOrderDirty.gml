// Feather disable all

/// @param parent

function __BentoMarkDrawOrderDirty(_parent)
{
    if (not BentoExists(_parent)) return;
    
    with(_parent.BENTO_VARS)
    {
        if (not __drawOrderDirty)
        {
            __drawOrderDirty = true;
            array_push(__layer.__dirtyChildOrderArray, self);
            
            __layer.__dirtyFlags |= __BENTO_DIRTY_DRAW;
        }
    }
}