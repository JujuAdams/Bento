// Feather disable all

/// @param [element=self]

function BentoLayoutSetOriginAuto(_element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__elementIsInstance && (not __layoutOriginAuto))
        {
            __layoutOriginAuto = true;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
    }
}