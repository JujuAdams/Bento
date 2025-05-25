// Feather disable all

/// Destroys a UI element.
/// 
/// @param [element=self]

function GuiDestroy(_element = self)
{
    if (__GuiExists(_element))
    {
        if (instance_exists(_element))
        {
            instance_destroy(_element);
        }
        else if (is_struct(_element))
        {
            _element.GUI_VARS.__Destroy();
        }
    }
}