// Feather disable all

/// Starts the hover state for an element. This must be called in the scope of a layer struct.
/// 
/// @param element
/// @param byNavigation

function __BentoSetHover(_element, _byNavigation)
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
            
            BentoScrollTo(BentoScrollGetSpeed(_element), _element);
        }
        
        __SetHoverElement(_element);
        
        with(_element.BENTO_VARS)
        {
            if (not __updating)
            {
                __updating = true;
                array_push(__layer.__updateElementArray, self)
            }
            
            if (_byNavigation)
            {
                __byNavigation = true;
            }
        }
    }
    else
    {
        __SetHoverElement(BENTO_NO_ELEMENT);
    }
    
    __hoverElementSoft = BENTO_NO_ELEMENT;
}