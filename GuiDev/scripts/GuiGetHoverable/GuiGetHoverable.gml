// Feather disable all

/// Returns whether an instance is hoverable (i.e. its "over" state can be set).
/// 
/// @param [instance=id]

function GuiGetHoverable(_instance = id)
{
    if (not __GuiGetHoverableInner(_instance)) return false;
    
    if (__GuiStepOrderGetIndex(_instance) == undefined)
    {
        //This instance doesn't exist in the Step order
        //This usually happens when a modal has overwritten prior instances
        return false;
    }
    
    return true;
}

function __GuiGetHoverableInner(_instance)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return false;
    
    if ((not _instance.visible) || _instance.__disable || _instance.__focusBlockHover)
    {
        return false;
    }
    
    if (_system.__navMode == GUI_NAV_DIRECTIONAL)
    {
        if (_instance.__behavior != GUI_BEHAVIOR_BUTTON)
        {
            return false;
        }
        
        var _tabData = __GuiTabGetData(_instance.__tabIdent);
        if (_tabData != undefined)
        {
            if (_tabData.__blockDirectionalWhenOpen && instance_exists(_tabData.__child))
            {
                return false;
            }
        }
    }
    
    if (instance_exists(_system.__popUpRoot) && (not GuiIsAncestor(_system.__popUpRoot, _instance)))
    {
        //This instance is outside the root pop-up
        return false;
    }
    
    return true;
}