// Feather disable all

/// Sets the parent for an instance, and whether that instance is "inside" or "outside" the new
/// parent. If the `inside` optional parameter isn't defined, the current "inside" state of the
/// target instance will be used.
/// 
/// @param parent
/// @param [inside]
/// @param [targetInstance]

function GuiSetParent(_parent, _inside = undefined, _targetInstance = id)
{
    static _system          = __GuiSystem();
    static _dirtyOrderArray = __GuiSystem().__dirtyOrderArray;
    
    if (not instance_exists(_targetInstance)) return;
    
    if (_inside == undefined)
    {
        _inside = _targetInstance.__inside;
    }
    
    _system.__stepDirty = true;
    _system.__drawDirty = true;
    
    __GuiRemoveParent(_targetInstance);
    _targetInstance.__parent = _parent;
    _targetInstance.__inside = _inside;
    
    with(_parent)
    {
        array_push(_inside? __childInsideArray : __childOutsideArray, _targetInstance);
        
        if (not __orderDirty)
        {
            __orderDirty = true;
            array_push(_dirtyOrderArray, id);
        }
    }
    
    if (not instance_exists(_targetInstance)) return;
    
    if (_inside == undefined)
    {
        _inside = _targetInstance.__inside;
    }
}