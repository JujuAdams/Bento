// Feather disable all

/// Starts the hold state for an instance.
/// 
/// @param instance

function __GuiNavStartHold(_element)
{
    if (GUI_EXISTS(_element) && (not GuiNavGetHold(_element)))
    {
        with(_element.GUI_VARS)
        {
            __holdState = GUI_PRESS;
            __layer.__holdElement = _element;
            
            if (not __updating)
            {
                __updating = true;
                array_push(__layer.__updateElementArray, _element)
            }
        }
    }
}