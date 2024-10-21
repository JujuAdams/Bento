// Feather disable all

/// Adjusts the `x` and `y` coordinates of an instance.
/// 
/// @param dX
/// @param dY
/// @param [instance=id]

function GuiMove(_dX, _dY, _instance = id)
{
    if ((_dX == 0) && (_dY == 0)) return;
    
    GuiMoveSolo(_dX, _dY, _instance);
    GuiMoveChildren(_dX, _dY, _instance);
}