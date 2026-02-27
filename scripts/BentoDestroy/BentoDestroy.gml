// Feather disable all

/// Destroys an element. The element may be an object instance or a struct.
/// 
/// @param [element=self]

function BentoDestroy(_element = self)
{
    if (BentoExists(_element))
    {
        if (instance_exists(_element))
        {
            instance_destroy(_element);
        }
        else if (is_struct(_element))
        {
            _element.BENTO_VARS.__Destroy();
        }
    }
}