// Feather disable all

/// Returns whether an instance is hoverable (i.e. its "over" state can be set).
/// 
/// @param [element=self]
/// @param [checkVisible=true]

function GuiGetHoverable(_element = self, _checkVisible = true)
{
    if (__GuiGetHoverableInner(_element, _checkVisible))
    {
        //TODO - We can cache this data when renewing the Step order
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
    if (not __GuiExists(_element)) return false;
    
    with(_element.GUI_VARS)
    {
        if (__disable) return false;
        
        //Don't hover ourselves if we have children
        //TODO - We can cache this data when renewing the Step order
        if (__branched && (array_length(__childArray) > 0))
        {
            return false;
        }
        
        var _layer = __layer;
        var _branchTop = _layer.__branchTop;
        
        if (_layer.__navPointer)
        {
            if (__GuiExists(_branchTop)
            &&  (_branchTop.GUI_VARS.__branchType == GUI_BRANCH_POINTER_CONSTRAIN)
            &&  (not GuiIsAncestor(_branchTop, _element)))
            {
                return false;
            }
        }
        else
        {
            if (__GuiExists(_branchTop) && (not GuiIsAncestor(_branchTop, _element)))
            {
                return false;
            }
            
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