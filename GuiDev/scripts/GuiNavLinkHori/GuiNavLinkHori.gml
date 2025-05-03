// Feather disable all

/// Creates a horizontal navigation link between two instances. When pressing left or right with
/// directional input, the cursor will jump between the two instances.
/// 
/// @param left
/// @param right

function GuiNavLinkHori(_left, _right)
{
    if (__GuiExists(_left)) _left.GUI_VARS.__navRight = _right;
    if (__GuiExists(_right)) _right.GUI_VARS.__navLeft = _left;
}