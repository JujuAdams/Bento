// Feather disable all

/// Returns whether the primary action has been activated and held on the element.
/// 
/// @param [element=self]

function BentoPrimaryGetLongHold(_element = self)
{
    return BentoExists(_element)? ((_element.BENTO_VARS.__primaryLongState & __BENTO_STATE_START) > 0) : false;
}