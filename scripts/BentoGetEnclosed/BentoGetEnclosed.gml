// Feather disable all

/// Returns whether an element is enclosed by its parent (or another ancestor element in the tree).
/// If the element doesn't exist, this function will return `false`.
/// 
/// N.B. This function will not work unless `BENTO_ALLOW_ENCLOSED_GETTER` has been set to `true`.
/// 
/// @param [element=self]

function BentoGetEnclosed(_element = self)
{
    if (not BENTO_ALLOW_ENCLOSED_GETTER)
    {
        if (BENTO_RUNNING_FROM_IDE)
        {
            __BentoError("`BENTO_ALLOW_ENCLOSED_GETTER` must be set to `true`");
        }
        else
        {
            return false;
        }
    }
    
    return BentoExists(_element)? _element.BENTO_VARS.__enclosed : false;
}