// Feather disable all

/// Returns the enclose type for the target parent element. If the element does not exist this
/// function will return `BENTO_ENCLOSE_NEVER`.
/// 
/// @param [element=self]

function BentoFocusGetEnclose(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__focusEncloseType : BENTO_ENCLOSE_NEVER;
}