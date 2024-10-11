// Feather disable all

/// @param left
/// @param right

function GuiNavLinkHori(_left, _right)
{
    if (instance_exists(_left)) _left.navRight = _right;
    if (instance_exists(_right)) _right.navLeft = _left;
}