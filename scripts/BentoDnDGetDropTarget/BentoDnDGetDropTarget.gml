// Feather disable all

/// @param [element=self]

function BentoDnDGetDropTarget(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return (__dndItemState == __BENTO_STATE_END)? __dndTargetElement : BENTO_NO_ELEMENT;
    }
    
    return BENTO_NO_ELEMENT;
}