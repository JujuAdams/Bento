// Feather disable all

/// Creates a horizontal navigation link between two instances. When pressing left or right with
/// directional input, the cursor will jump between the two instances.
/// 
/// @param left
/// @param right

function BentoLinkHori(_left, _right)
{
    if (BentoExists(_left)) _left.BENTO_VARS.__linkRight = _right;
    if (BentoExists(_right)) _right.BENTO_VARS.__linkLeft = _left;
}