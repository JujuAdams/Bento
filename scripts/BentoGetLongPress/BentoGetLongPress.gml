// Feather disable all

/// @param [element=self]

function BentoGetLongPress(_element = self)
{
    if (not BentoExists(_element)) return false;
    
    return _element.BENTO_VARS.__longPressEnabled;
}