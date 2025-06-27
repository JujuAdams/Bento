// Feather disable all

/// Sets the parent for an instance.
/// 
/// @param parent
/// @param [target=self]

function BentoSetParent(_parent, _target = self)
{
    if ((not BentoExists(_parent)) || (not BentoExists(_target))) return;
    
    __BentoRemoveParent(_target);
    
    with(_target.BENTO_VARS)
    {
        //Mark the layer we're leaving as dirty
        with(__layer)
        {
            __dirtyFlags |= __BENTO_DIRTY_ALL;
        }
        
        __parent = _parent;
        __layer = _parent.BENTO_VARS.__layer;
        
        //Mark the layer we're entering as dirty
        with(__layer)
        {
            __dirtyFlags |= __BENTO_DIRTY_ALL;
        }
        
        with(_parent)
        {
            array_push(BENTO_VARS.__childArray, _target);
            array_push(BENTO_VARS.__childDrawArray, _target);
        
            __BentoMarkDrawOrderDirty(self);
            BentoScrollLimitsMarkDirty(self);
        }
    }
}