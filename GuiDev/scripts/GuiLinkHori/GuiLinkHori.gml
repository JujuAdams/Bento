// Feather disable all

/// Creates a horizontal navigation link between two instances. When pressing left or right with
/// directional input, the cursor will jump between the two instances.
/// 
/// @param left
/// @param right

function GuiLinkHori(_left, _right)
{
    if (GuiExists(_left)) _left.GUI_VARS.__linkRight = _right;
    if (GuiExists(_right)) _right.GUI_VARS.__linkLeft = _left;
}