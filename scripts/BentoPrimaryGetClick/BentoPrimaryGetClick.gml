// Feather disable all

/// Returns whether the element has been clicked. This may trigger when the primary button has been
/// pressed or released depending on a few factors. An element will typically only return that is
/// has been clicked when the primary button has been released. However, elements will return that
/// they have been clicked on pressed in the following situations:
/// 
/// - A layer is using a navigation input mode
/// - A layer is using the mouse input mode and `BENTO_POINTER_CLICK_ON_PRESS` is `true` and the
///   element is not inside a scrolling container
/// - A layer is using the touch input mode and the element is not inside a scrolling container
/// 
/// @param [element=self]

function BentoPrimaryGetClick(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return __layer.__primaryConsumed? false : (__clickState == 0b01);
    }
    
    return false;
}