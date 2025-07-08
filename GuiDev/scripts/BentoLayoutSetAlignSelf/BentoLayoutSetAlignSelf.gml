// Feather disable all

/// Sets the alignment for the element relative to the space available to it. For example, if an
/// element's parent has a grid layout then the "space available" for the element itself is the
/// grid cell. If the element's parent has no layout then the space available is the entirety of
/// the parent element (minus any padding on the parent).
/// 
/// To that end, this function allows you to specify where within the available space the element
/// is positioned. `hAlign` and `vAlign` should be a value between `0` and `1`. If you choose a
/// value of `0`, that will align an element to the left or the top of the available space. If you
/// choose a value of `1`, that will align an element to the right or the bottom. A value of `0.5`
/// therefore is the center or middle of the available space. You may pass `undefined` as either
/// parameter to not change the existing value.
///  
/// If you have set the resize type for a particular axis to `BENTO_RESIZE_INFLATE` then alignment
/// will usually have no effect - the element will occupy 100% of the available space. However, if
/// the element has a minimum size that prevents it from fitting inside its parent then alignment
/// will have some effect.
/// 
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