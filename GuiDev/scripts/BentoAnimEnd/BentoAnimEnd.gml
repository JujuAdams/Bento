// Feather disable all

/// @param [skip=true]
/// @param [element=self]

function BentoAnimEnd(_skip = true, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (_skip)
        {
            
        }
        
        __animSimple = __BENTO_ANIM_INACTIVE;
        __animString = "";
    }
}