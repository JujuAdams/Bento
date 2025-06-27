// Feather disable all

/// @param buttonType
/// @param [element=self]

function BentoSetButton(_buttonType, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__buttonType == _buttonType) return;
        __buttonType = _buttonType;
        
        //Update data relating to buttons
        __layer.__dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
    }
}