// Feather disable all

/// Returns whether the primary action has released (newly un-held) the element.
/// 
/// N.B. This is NOT the same as clicking an element as an element may be released for many
///      reasons other than user intent. To check whether an element has been clicked, please use
///      `BentoPrimaryGetClick()`.
/// 
/// @param [element]

function BentoPrimaryGetLongRelease(_element = self)
{
    return BentoExists(_element)? (_element.BENTO_VARS.__primaryLongState == __BENTO_STATE_END) : false;
}