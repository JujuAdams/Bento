// Feather disable all

/// Starts the hold state for an element.
/// 
/// @param element

function __BentoStartHold(_element)
{
    if (BentoExists(_element) && (not BentoPrimaryGetHold(_element)))
    {
        with(_element.BENTO_VARS)
        {
            __primaryState = __BENTO_STATE_START;
            __layer.__holdElement = _element;
            
            __BentoSetAsUpdating();
        }
    }
}