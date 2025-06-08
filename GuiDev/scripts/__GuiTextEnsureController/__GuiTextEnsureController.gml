// Feather disable all

function __GuiTextEnsureController()
{
    if (instance_exists(__GuiTextAsyncController))
    {
        return __GuiTextAsyncController.id;
    }
    else
    {
        instance_activate_object(__GuiTextAsyncController);
        if (instance_exists(__GuiTextAsyncController))
        {
            return __GuiTextAsyncController.id;
        }
        else
        {
            return instance_create_depth(0, 0, 0, __GuiTextAsyncController);
        }
    }
}