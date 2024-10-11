// Feather disable all

/// @param instance
/// @param padding

function GuiScissorSetupFromBounds(_instance, _padding)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance)
    {
        GuiScissorSetup(id, x - width/2 + _padding, y - height/2 + _padding, x + width/2 - _padding, y + height/2 - _padding);
    }
}