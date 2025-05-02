// Feather disable all

/// Sets the parent for an instance, and whether that instance is "inside" or "outside" the new
/// parent. If the `inside` optional parameter isn't defined, the current "inside" state of the
/// target instance will be used.
/// 
/// @param parent
/// @param [targetInstance=id]

function GuiSetParent(_parent, _targetInstance = id)
{
    if ((not instance_exists(_parent)) || (not instance_exists(_targetInstance))) return;
    
    __GuiRemoveParent(_targetInstance);
    
    with(_targetInstance.GUI_VARS)
    {
        //Mark the environment we're leaving as dirty
        with(__environment)
        {
            __layoutDirty = true;
            __stepDirty   = true;
            __drawDirty   = true;
        }
        
        __parent = _parent;
        __environment = _parent.GUI_VARS.__environment;
        
        //Mark the environment we're entering as dirty
        with(__environment)
        {
            __layoutDirty = true;
            __stepDirty   = true;
            __drawDirty   = true;
        }
        
        with(_parent)
        {
            array_push(GUI_VARS.__childArray, _targetInstance);
        
            __GuiMarkChildOrderDirty(id);
            GuiScrollLimitsMarkDirty(id);
        }
    }
}