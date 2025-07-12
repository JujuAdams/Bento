// Feather disable all

/// Starts the hover state for an element.
/// 
/// @param element

function __BentoStartHover(_element)
{
    if (BentoExists(_element))
    {
        __cursorLastL = _element.bentoLeft;
        __cursorLastT = _element.bentoTop;
        __cursorLastR = _element.bentoRight;
        __cursorLastB = _element.bentoBottom;
        
        if (__navDirectional)
        {
            __directionalLastX = 0.5*(__cursorLastL + __cursorLastR);
            __directionalLastY = 0.5*(__cursorLastT + __cursorLastB);
            
            BentoScrollTo(undefined, _element);
        }
        
        __hoverElement = _element;
        
        with(_element.BENTO_VARS)
        {
            if (not __updating)
            {
                __updating = true;
                array_push(__layer.__updateElementArray, self)
            }
        }
    }
    else
    {
        __hoverElement = BENTO_NO_ELEMENT;
    }
    
    __hoverElementSoft = BENTO_NO_ELEMENT;
}