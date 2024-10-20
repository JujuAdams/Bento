// Feather disable all

/// @param [padding=0]
/// @param [instance=id]

function GuiScissorSetup(_padding = 0, _instance = id)
{
    with(_instance)
    {
        GuiScissorSetupExt(x - width/2 + _padding, y - height/2 + _padding, x + width/2 - _padding, y + height/2 - _padding);
    }
}