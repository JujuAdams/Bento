// Feather disable all

/// Adjusts the `x` and `y` coordinates of an instance. This function, unlike `GuiMove()`, will
/// not move the target instance's children.
/// 
/// @param dX
/// @param dY
/// @param [instance=id]

function GuiMoveSolo(_dX, _dY, _instance = id)
{
    if ((_dX == 0) && (_dY == 0)) return;
    
    with(_instance)
    {
        x += _dX;
        y += _dY;
        
        if (__scissorState)
        {
            __scissorLeft   += _dX;
            __scissorTop    += _dY;
            __scissorRight  += _dX;
            __scissorBottom += _dY;
        }
    }
}