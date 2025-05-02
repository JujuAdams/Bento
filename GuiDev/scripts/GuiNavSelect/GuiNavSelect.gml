// Feather disable all

/// Selects an instance (if possible). This function only works when the navigation mode is set to
/// `GUI_NAV_DIRECTIONAL`.
/// 
/// @param instance

function GuiNavSelect(_instance)
{
    with(GUI_ENVIRONMENT)
    {
        __overInstance     = _instance;
        __overInstanceSoft = noone;
    }
}