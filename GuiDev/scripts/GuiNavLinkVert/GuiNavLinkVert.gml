// Feather disable all

/// Creates a vertical navigation link between two instances. When pressing up or down on your
/// gamepad, the cursor will jump between the two instances.
/// 
/// @param up
/// @param down

function GuiNavLinkVert(_up, _down)
{
    if (instance_exists(_up)) _up.navDown = _down;
    if (instance_exists(_down)) _down.navUp = _up;
}