// Feather disable all

/// @param method
/// @param duration
/// @param [metadata]
/// @param [destroyAtEnd=true]
/// @param [element=self]

function BentoAnimStartMethod(_method, _duration, _metadata = undefined, _destroyAtEnd = true, _element = self)
{
    with(_element)
    {
        BentoAnimEnd(false, _element);
        
        __animPending        = true;
        __animDuration       = max(1, _duration);
        __animMethod         = _method;
        __animMethodMetadata = _metadata
        __animDestroyAtEnd   = _destroyAtEnd;
        
        with(__layer)
        {
            if (not ds_map_exists(__animatingMap, _element))
            {
                array_push(__animatingArray, _element);
                __animatingMap[? _element] = true;
            }
        }
    }
}