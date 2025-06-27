// Feather disable all

/// Returns whether the primary action has pressed (newly held) the instance.
/// 
/// N.B. This is NOT the same as clicking an instance as an instance may be pressed for many
///      reasons other than user intent. To check whether an instance has been clicked, please use
///      `BentoPrimaryGetClick()`.
/// 
/// @param [element]

function BentoPrimaryGetPress(_element = self)
{
    return BentoExists(_element)? (_element.BENTO_VARS.__primaryState == __BENTO_START) : false;
}