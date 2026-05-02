// Feather disable all

/// Creates a horizontal navigation link between two elements. When pressing left or right with
/// directional input, the cursor will jump between the two elements rather than performing a
/// general raycast.
/// 
/// N.B. The linking feature only applies to directional (keyboard and gamepad) input.
/// 
/// @param left
/// @param right

function BentoLinkHori(_left, _right)
{
    if (BentoExists(_left)) _left.BENTO_VARS.__linkRight = _right;
    if (BentoExists(_right)) _right.BENTO_VARS.__linkLeft = _left;
}