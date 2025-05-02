// Feather disable all

/// Returns whether an instance is hoverable (i.e. its "over" state can be set).
/// 
/// @param [instance=id]
/// @param [checkVisible=true]

function GuiGetHoverable(_instance = id, _checkVisible = true)
{
    if (not __GuiGetHoverableInner(_instance, _checkVisible)) return false;
    
    if (__GuiStepOrderGetIndex(_instance) == undefined)
    {
        //This instance doesn't exist in the Step order
        //This usually happens when a modal has overwritten prior instances
        return false;
    }
    
    return true;
}

function __GuiGetHoverableInner(_instance, _checkVisible)
{
    if (not instance_exists(_instance)) return false;
    var _gui = _instance.GUI_STRUCT;
    
    //Basic validity checks
    if ((not _instance.visible) || _gui.__disable)
    {
        return false;
    }
    
    //We're not hoverable if we're focused and we have children (see `GuiNavSetFocus()`)
    if (_gui.__focusBlockHover)
    {
        return false;
    }
    
    var _environment = GUI_ENVIRONMENT;
    if (instance_exists(_environment.__popUpRoot) && (not GuiIsAncestor(_environment.__popUpRoot, _instance)))
    {
        return false;
    }
    
    if (_environment.__navMode == GUI_NAV_DIRECTIONAL)
    {
        //In directional mode, only buttons are selectable
        if (_gui.__behavior != GUI_BEHAVIOR_BUTTON)
        {
            return false;
        }
        
        var _tabData = __GuiTabGetData(_gui.__tabIdent);
        if (_tabData != undefined)
        {
            if (_tabData.__blockDirectionalWhenOpen && instance_exists(_tabData.__child))
            {
                return false;
            }
        }
        
        if (_checkVisible && (not GuiGetVisibleInScroll(true, _instance)))
        {
            return false;
        }
    }
    
    return true;
}