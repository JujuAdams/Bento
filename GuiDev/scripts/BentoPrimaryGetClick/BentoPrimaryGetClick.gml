// Feather disable all

/// Returns whether the instance has been clicked.
/// 
/// @param [element=self]

function BentoPrimaryGetClick(_element = self)
{
    if (not BentoExists(_element)) return false;
    
    with(_element.BENTO_VARS)
    {
        return __layer.__primaryConsumed? false : __click;
    }
    
    return false;
}