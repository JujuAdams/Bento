// Feather disable all

/// Starts the over state for an instance.
/// 
/// @param instance

function __GuiStartOver(_element)
{
    if (GuiExists(_element))
    {
        if (__navDirectional)
        {
            __directionalLastX = _element.guiLeft;
            __directionalLastY = _element.guiTop;
            
            __cursorLastL = _element.guiLeft;
            __cursorLastT = _element.guiTop;
            __cursorLastR = _element.guiRight;
            __cursorLastB = _element.guiBottom;
            
            GuiScrollTo(undefined, _element);
        }
        
        __overElement = _element;
        
        with(_element.GUI_VARS)
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
        __overElement = noone;
    }
    
    __overElementSoft = noone;
}