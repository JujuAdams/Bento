// Feather disable all

/// @param [element=self]

function BentoLayoutSetOriginAuto(_element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__elementIsInstance && (not __layoutOriginAuto))
        {
            __layoutOriginAuto = true;
            __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
        }
    }
}