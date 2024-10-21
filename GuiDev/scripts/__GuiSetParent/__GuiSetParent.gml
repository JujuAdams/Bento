// Feather disable all

/// Sets the parent for an instance, and whether that instance is "inside" or "outside" the new
/// parent.
/// 
/// @param child
/// @param parent
/// @param inside

function __GuiSetParent(_child, _parent, _inside)
{
    static _system          = __GuiSystem();
    static _dirtyOrderArray = __GuiSystem().__dirtyOrderArray;
    
    if (not instance_exists(_child)) return;
    
    _system.__stepDirty = true;
    _system.__drawDirty = true;
    
    __GuiRemoveParent(_child);
    _child.__parent = _parent;
    
    with(_parent)
    {
        array_push(_inside? __childInsideArray : __childOutsideArray, _child);
        
        if (not __orderDirty)
        {
            __orderDirty = true;
            array_push(_dirtyOrderArray, id);
        }
    }
}