// Feather disable all

/// @param [hAlign]
/// @param [vAlign]
/// @param [element=self]

function BentoLayoutSetAlignSelf(_hAlign, _vAlign, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (_hAlign != undefined)
        {
            if (__layoutAlignH != _hAlign)
            {
                __layoutAlignH = _hAlign;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
        
        if (_vAlign != undefined)
        {
            if (__layoutAlignV != _vAlign)
            {
                __layoutAlignV = _vAlign;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
    }
}