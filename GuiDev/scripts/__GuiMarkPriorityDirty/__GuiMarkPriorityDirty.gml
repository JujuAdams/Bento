// Feather disable all

/// @param parent

function __GuiMarkPriorityDirty(_parent)
{
    static _dirtyPriorityArray = __GuiSystem().__dirtyPriorityArray;
    
    if (not instance_exists(_parent)) return;
    
    if (not __priorityDirty)
    {
        _parent.__priorityDirty = true;
        array_push(_dirtyPriorityArray, _parent);
    }
}