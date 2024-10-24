// Feather disable all

/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [instance=id]

function GuiScissorSetupExt(_left, _top, _right, _bottom, _instance = id)
{
    with(_instance)
    {
        GuiScissorSetupAbsolute(x - width/2 + _left, y - height/2 + _top, x + width/2 - _right, y + height/2 - _bottom);
    }
}