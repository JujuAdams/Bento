// Feather disable all

/// Creates a vertical navigation link between two elements. When pressing up or down with
/// navigation input, the cursor will jump between the two elements rather than performing a
/// general raycast.
/// 
/// N.B. The linking feature only applies to navigation (keyboard and gamepad) input.
/// 
/// @param up
/// @param down

function BentoLinkVert(_up, _down)
{
    if (BentoExists(_up)) _up.BENTO_VARS.__linkDown = _down;
    if (BentoExists(_down)) _down.BENTO_VARS.__linkUp = _up;
}