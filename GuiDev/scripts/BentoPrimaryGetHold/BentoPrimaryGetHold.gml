// Feather disable all

/// Returns whether the primary action has been activated and held on the instance.
/// 
/// @param [element=self]

function BentoPrimaryGetHold(_element = self)
{
    if (not BentoExists(_element)) return false;
    return ((_element.BENTO_VARS.__primaryState & __BENTO_START) > 0);
}