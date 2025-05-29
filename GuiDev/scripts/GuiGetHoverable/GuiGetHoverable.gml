// Feather disable all

/// Returns whether an instance is hoverable (i.e. its "over" state can be set).
/// 
/// @param [element=self]
/// @param [checkVisible=true]

function GuiGetHoverable(_element = self, _checkVisible = true)
{
    if (not __GuiExists(_element)) return false;
    
    with(_element.GUI_VARS)
    {
        if (__disable) return false;
        
        //Don't hover ourselves if we have children
        //TODO - We can cache this data when renewing the Step order
        if (__focused && (array_length(__childArray) > 0))
        {
            return false;
        }
        
        var _layer = __layer;
        var _focusTop = _layer.__focusTop;
        
        if (_layer.__navPointer)
        {
            if (__GuiExists(_focusTop)
            &&  (_focusTop.GUI_VARS.__focusType == GUI_FOCUS_POINTER_CONSTRAIN) //TODO - Iterate over focus stack to find a POINTER_CONSTRAIN
            &&  (not GuiIsAncestor(_focusTop, _element)))
            {
                return false;
            }
        }
        else if (_layer.__navDirectional)
        {
            if not (__buttonType & GUI_BUTTON_DIRECTIONAL)
            {
                return false;
            }
            
            if (__GuiExists(_focusTop) && (not GuiIsAncestor(_focusTop, _element)))
            {
                return false;
            }
            
            if (_checkVisible && (not GuiGetVisibleInScroll(true, _element)))
            {
                return false;
            }
        }
        else
        {
            //Invalid navigation mode, perhaps `GUI_MODE_UNKNOWN`
            return false;
        }
        
        return true;
    }
    
    return false;
}