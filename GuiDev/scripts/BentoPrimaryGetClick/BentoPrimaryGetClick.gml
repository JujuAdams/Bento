// Feather disable all

/// Returns whether the element has been clicked. This may trigger when the primary button has been
/// pressed or released depending on a few factors. An element will typically only return that is
/// has been clicked when the primary button has been released. However, elements will return that
/// they have been clicked on pressed in the following situations:
/// 
/// - A layer is using a directional input mode
/// - A layer is using the mouse input mode and `BENTO_POINTER_CLICK_ON_PRESS` is `true` and the
///   element is not inside a scrolling container
/// - A layer is using the touch input mode and the element is not inside a scrolling container
/// 
/// @param [element=self]


            if (other.__navDirectional)
            {
                var _clickOnPress = true;
            }
            else if (not BentoExists(__BentoScrollFindParent(_element)))
            {
                var _clickOnPress = other.__navPointer && (BENTO_POINTER_CLICK_ON_PRESS || (other.__navMode == BENTO_MODE_TOUCH));
            }
            else
            {
                var _clickOnPress = false;
            }

function BentoPrimaryGetClick(_element = self)
{
    if (not BentoExists(_element)) return false;
    
    with(_element.BENTO_VARS)
    {
        return __layer.__primaryConsumed? false : __click;
    }
    
    return false;
}