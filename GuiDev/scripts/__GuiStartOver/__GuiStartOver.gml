// Feather disable all

/// Starts the over state for an instance.
/// 
/// @param instance

function __GuiStartOver(_element)
{
    if (__GuiExists(_element))
    {
        if (__navDirectional)
        {
            __directionalLastX = _element.x;
            __directionalLastY = _element.y;
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