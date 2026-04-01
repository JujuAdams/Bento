// Feather disable all

/// @param [element=self]

function BentoDnDGetItemData(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return __dndItemData;
    }
    
    return undefined;
}