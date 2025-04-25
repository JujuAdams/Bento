// Feather disable all

/// Sets the parent for an instance, and whether that instance is "inside" or "outside" the new
/// parent. If the `inside` optional parameter isn't defined, the current "inside" state of the
/// target instance will be used.
/// 
/// @param parent
/// @param [targetInstance=id]

function GuiSetParent(_parent, _targetInstance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_targetInstance)) return;
    
    _system.__layoutDirty = true;
    _system.__stepDirty   = true;
    _system.__drawDirty   = true;
    
    __GuiRemoveParent(_targetInstance);
    _targetInstance.__gui.__parent = _parent;
    
    with(_parent)
    {
        array_push(__gui.__childArray, _targetInstance);
        
        __GuiMarkChildOrderDirty(id);
        GuiScrollLimitsMarkDirty(id);
    }
    
    if (not instance_exists(_targetInstance)) return;
}