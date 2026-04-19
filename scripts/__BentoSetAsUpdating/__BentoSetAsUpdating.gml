/// Pushes an element to its layer's "updating" array. This function should be calle din the scope
/// of an element's BENTO_VARS.

function __BentoSetAsUpdating()
{
    if (not __updating)
    {
        __updating = true;
        array_push(__layer.__updateElementArray, self)
    }
}