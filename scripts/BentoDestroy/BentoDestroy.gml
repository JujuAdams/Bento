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
            if (not __BentoObjectInheritsFrom(_element.object_index, oBentoAncestor))
            {
                if (BENTO_SAFE)
                {
                    __BentoError($"Trying to destroy object instance that does not inherit from `oBentoAncestor` ({object_get_name(_element.object_index)}:{real(id)})");
                }
            }
            else
            {
                instance_destroy(_element);
            }
        }
        else if (is_struct(_element))
        {
            _element.BENTO_VARS.__Destroy();
        }
    }
}