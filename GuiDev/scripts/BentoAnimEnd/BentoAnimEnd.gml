// Feather disable all

/// @param [skip=true]
/// @param [element=self]

function BentoAnimEnd(_skip = true, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__animPending)
        {
            if (_skip)
            {
                __animMethod(1, __animMethodMetadata);
                
                if (__animDestroyAtEnd)
                {
                    BentoDestroy(_element);
                }
            }
            
            __animPending        = false;
            __animElapsed        = 0;
            __animDuration       = 0;
            __animMethod         = undefined;
            __animMethodMetadata = undefined;
            __animDestroyAtEnd   = false;
        }
        
        with(__layer)
        {
            ds_map_delete(__animatingMap, _element);
            
            var _index = array_get_index(__animatingArray, _element);
            if (_index >= 0) array_delete(__animatingArray, _index, 1);
        }
    }
}