// Feather disable all

/// Returns the number of children of a parent element.
/// 
/// @param [parent=self]

function BentoGetChildCount(_parent = self)
{
    return BentoExists(_parent)? array_length(_parent.BENTO_VARS.__childArray) : 0;
}