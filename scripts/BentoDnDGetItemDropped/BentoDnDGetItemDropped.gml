// Feather disable all

/// @param [element=self]

function BentoDnDGetItemDropped(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return (__dndItemState == __BENTO_END);
    }
    
    return false;
}