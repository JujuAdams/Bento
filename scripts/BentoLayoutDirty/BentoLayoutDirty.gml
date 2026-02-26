// Feather disable all

/// @param [element=self]

function BentoLayoutDirty(_element = self)
{
    with(__BentoGetVars(_element))
    {
        __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
    }
}