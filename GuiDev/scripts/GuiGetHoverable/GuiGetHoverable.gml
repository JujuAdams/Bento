// Feather disable all

/// Returns whether an instance is hoverable (i.e. its "over" state can be set).
/// 
/// @param [element=self]
/// @param [checkVisible=true]

function GuiGetHoverable(_element = self, _checkVisible = true)
{
    if (__GuiGetHoverableInner(_element, _checkVisible))
    {
        //Don't return `true` if the instance isn't 
        var _stepOrder = _element.GUI_VARS.__layer.__stepOrder;
        var _i = 0;
        repeat(array_length(_stepOrder))
        {
            with(method_get_self(_stepOrder[_i]))
            {
                if (self == _element)
                {
                    return true;
                }
            }
            
            ++_i;
        }
    }
    
    return false;
}

function __GuiGetHoverableInner(_element, _checkVisible)
{
    if (not GUI_EXISTS(_element)) return false;
    
    with(_element.GUI_VARS)
    {
        //Basic disabled check
        if (__disable)
        {
            return false;
        }
        
        //We're not hoverable if we're focused and we have children (see `GuiNavSetFocus()`)
        if (__focusBlockHover)
        {
            return false;
        }
        
        var _layer = __layer;
        if (GUI_EXISTS(_layer.__popUpRoot) && (not GuiIsAncestor(_layer.__popUpRoot, _element)))
        {
            return false;
        }
        
        if (_layer.__navMode == GUI_NAV_DIRECTIONAL)
        {
            //In directional mode, only buttons are selectable
            if (__behavior != GUI_BEHAVIOR_BUTTON)
            {
                return false;
            }
            
            if (_checkVisible && (not GuiGetVisibleInScroll(true, _element)))
            {
                return false;
            }
        }
        
        return true;
    }
}