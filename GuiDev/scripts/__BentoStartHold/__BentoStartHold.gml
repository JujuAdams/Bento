// Feather disable all

/// Starts the hold state for an instance.
/// 
/// @param instance

function __BentoStartHold(_element)
{
    if (BentoExists(_element) && (not BentoPrimaryGetHold(_element)))
    {
        with(_element.GUI_VARS)
        {
            __primaryState = __GUI_START;
            __layer.__holdElement = _element;
            
            if (not __updating)
            {
                __updating = true;
                array_push(__layer.__updateElementArray, _element)
            }
        }
    }
}