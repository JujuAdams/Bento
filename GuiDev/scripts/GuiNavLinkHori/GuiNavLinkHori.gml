// Feather disable all

/// Creates a horizontal navigation link between two instances. When pressing left or right on your
/// gamepad, the cursor will jump between the two instances.
/// 
/// @param left
/// @param right

function GuiNavLinkHori(_left, _right)
{
    if (instance_exists(_left)) _left.navRight = _right;
    if (instance_exists(_right)) _right.navLeft = _left;
}