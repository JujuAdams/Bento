// Feather disable all

/// @param dX
/// @param dY
/// @param [instance=id]

function GuiMoveSolo(_dX, _dY, _instance = id)
{
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