// Feather disable all

/// @param [element=self]

function BentoCarryGetItemDropped(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return (__carryItemState == __BENTO_STATE_END);
    }
    
    return false;
}