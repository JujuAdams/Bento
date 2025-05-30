// Feather disable all

/// Sets the parent for an instance.
/// 
/// @param parent
/// @param [target=self]

function GuiSetParent(_parent, _target = self)
{
    if ((not GuiExists(_parent)) || (not GuiExists(_target))) return;
    
    __GuiRemoveParent(_target);
    
    with(_target.GUI_VARS)
    {
        //Mark the layer we're leaving as dirty
        with(__layer)
        {
            __layoutDirty = true;
            __stepDirty   = true;
            __drawDirty   = true;
        }
        
        __parent = _parent;
        __layer = _parent.GUI_VARS.__layer;
        
        //Mark the layer we're entering as dirty
        with(__layer)
        {
            __layoutDirty = true;
            __stepDirty   = true;
            __drawDirty   = true;
        }
        
        with(_parent)
        {
            array_push(GUI_VARS.__childArray, _target);
        
            __GuiMarkChildOrderDirty(self);
            GuiScrollLimitsMarkDirty(self);
        }
    }
}