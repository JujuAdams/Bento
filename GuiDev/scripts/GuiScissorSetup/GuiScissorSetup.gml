// Feather disable all

/// Sets up scissoring for an instance. Child instances that are "inside" the parent will have
/// their graphics clipped inside parent instance. The `padding` parameter allows you to make the
/// scissor region smaller than the parent's bounding box with the padding being applied equally
/// in all directions.
/// 
/// @param [padding=0]
/// @param [instance=id]

function GuiScissorSetup(_padding = 0, _instance = id)
{
    with(_instance)
    {
        GuiScissorSetupExt(x - width/2 + _padding, y - height/2 + _padding, x + width/2 - _padding, y + height/2 - _padding);
    }
}