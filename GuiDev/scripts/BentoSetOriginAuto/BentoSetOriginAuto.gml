// Feather disable all

/// @param [element=self]

function BentoSetOriginAuto(_element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__elementIsInstance && (not __originAuto))
        {
            __originAuto = true;
            
            with(_element)
            {
                __BentoUpdateElementXY();
            }
        }
    }
}