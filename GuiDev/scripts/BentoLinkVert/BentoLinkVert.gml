// Feather disable all

/// Creates a vertical navigation link between two instances. When pressing up or down with
/// directional input, the cursor will jump between the two instances.
/// 
/// @param up
/// @param down

function BentoLinkVert(_up, _down)
{
    if (BentoExists(_up)) _up.BENTO_VARS.__linkDown = _down;
    if (BentoExists(_down)) _down.BENTO_VARS.__linkUp = _up;
}