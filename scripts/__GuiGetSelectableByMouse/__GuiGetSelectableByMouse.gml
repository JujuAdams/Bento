// Feather disable all

/// @param instance

function __GuiGetSelectableByMouse(_instance)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return false;
    
    if ((not _instance.visible) || _instance.__disable)
    {
        return false;
    }
    
    if (__GuiStepOrderGetIndex(_instance) == undefined)
    {
        //This instance doesn't exist in the Step order
        //This usually happens when a modal has overwritten prior instances
        return false;
    }
    else if (instance_exists(_system.__popUpRoot) && (not GuiIsAncestor(_system.__popUpRoot, _instance)))
    {
        //This instance is outside the root pop-up
        return false;
    }
    
    return true;
}