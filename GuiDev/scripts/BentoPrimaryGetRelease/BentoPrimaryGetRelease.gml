// Feather disable all

/// Returns whether the primary action has released (newly un-held) the instance.
/// 
/// N.B. This is NOT the same as clicking an instance as an instance may be released for many
///      reasons other than user intent. To check whether an instance has been clicked, please use
///      `BentoPrimaryGetClick()`.
/// 
/// @param [instance]

function BentoPrimaryGetRelease(_element = self)
{
    if (not BentoExists(_element)) return false;
    return (_element.BENTO_VARS.__primaryState == __BENTO_END);
}