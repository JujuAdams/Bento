// Feather disable all

/// Creates a horizontal navigation link between two elements. When pressing left or right with
/// navigation input, the cursor will jump between the two elements rather than performing general
/// navigation.
/// 
/// N.B. The linking feature only applies to navigation (keyboard and gamepad) input modes.
/// 
/// @param left
/// @param right

function BentoNavigationLinkX(_left, _right)
{
    if (BentoExists(_left)) _left.BENTO_VARS.__navigationLinkRight = _right;
    if (BentoExists(_right)) _right.BENTO_VARS.__navigationLinkLeft = _left;
}