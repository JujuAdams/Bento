// Feather disable all

/// @param dX
/// @param dY
/// @param [instance=id]

function GuiMove(_dX, _dY, _instance = id)
{
    GuiMoveSolo(_dX, _dY, _instance);
    GuiMoveChildren(_dX, _dY, _instance);
}