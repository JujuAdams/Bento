// Feather disable all

/// Creates a vertical navigation link between two instances. When pressing up or down with
/// directional input, the cursor will jump between the two instances.
/// 
/// @param up
/// @param down

function GuiNavLinkVert(_up, _down)
{
    if (instance_exists(_up)) _up.__gui.navDown = _down;
    if (instance_exists(_down)) _down.__gui.navUp = _up;
}