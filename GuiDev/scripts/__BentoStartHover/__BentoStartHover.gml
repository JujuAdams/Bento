// Feather disable all

/// Starts the over state for an instance.
/// 
/// @param instance

function __BentoStartHover(_element)
{
    if (BentoExists(_element))
    {
        if (__navDirectional)
        {
            __directionalLastX = _element.bentoLeft;
            __directionalLastY = _element.bentoTop;
            
            __cursorLastL = _element.bentoLeft;
            __cursorLastT = _element.bentoTop;
            __cursorLastR = _element.bentoRight;
            __cursorLastB = _element.bentoBottom;
            
            BentoScrollTo(undefined, _element);
        }
        
        __hoverElement = _element;
        
        with(_element.BENTO_VARS)
        {
            if (not __updating)
            {
                __updating = true;
                array_push(__layer.__updateElementArray, _element)
            }
        }
    }
    else
    {
        __hoverElement = BENTO_NO_ELEMENT;
    }
    
    __hoverElementSoft = BENTO_NO_ELEMENT;
}