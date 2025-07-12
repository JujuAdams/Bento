// Feather disable all

function __BentoTextEnsureController()
{
    if (instance_exists(__BentoTextAsyncController))
    {
        return __BentoTextAsyncController.id;
    }
    else
    {
        instance_activate_object(__BentoTextAsyncController);
        if (instance_exists(__BentoTextAsyncController))
        {
            return __BentoTextAsyncController.id;
        }
        else
        {
            return instance_create_depth(0, 0, 0, __BentoTextAsyncController);
        }
    }
}