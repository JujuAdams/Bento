// Feather disable all

/// @param up
/// @param down

function GuiNavLinkVert(_up, _down)
{
    if (instance_exists(_up)) _up.navDown = _down;
    if (instance_exists(_down)) _down.navUp = _up;
}