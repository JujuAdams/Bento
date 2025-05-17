// Feather disable all

/// Creates a vertical navigation link between two instances. When pressing up or down with
/// directional input, the cursor will jump between the two instances.
/// 
/// @param up
/// @param down

function GuiLinkVert(_up, _down)
{
    if (__GuiExists(_up)) _up.GUI_VARS.__linkDown = _down;
    if (__GuiExists(_down)) _down.GUI_VARS.__linkUp = _up;
}