// Feather disable all

/// Returns whether long press has been enabled for this element.
/// 
/// N.B. Regardless of the state that this function returns, an element can only receive a long
///      press if it is also a valid button.
/// 
/// To detect whether a long press has occurred, please use the `BentoPrimaryGetLong*()` functions.
/// 
/// @param [element=self]

function BentoGetLongPress(_element = self)
{
    if (not BentoExists(_element)) return false;
    
    return _element.BENTO_VARS.__longPressEnabled;
}