// Feather disable all

/// @param [element=self]

function BentoPrimaryGetLongClick(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return __layer.__primaryConsumed? false : (__clickState == 0b10);
    }
    
    return false;
}