// Feather disable all

/// Returns whether an element is fully visible and is not obscured by any clipping regions.
/// 
/// @param [element=self]

function BentoClipGetFullyVisible(_element = self)
{
    if (not BentoExists(_element)) return false;
    
    var _scissorVisibility = _element.BENTO_VARS.__scissorVisibility;
    if (_scissorVisibility == BENTO_VISIBLE_NONE)
    {
        return false;
    }
    else if (_scissorVisibility == BENTO_VISIBLE_FULL)
    {
        return true;
    }
    else // (_scissorVisibility == BENTO_VISIBLE_PARTIAL)
    {
        //Test for oversize
        
        //FIXME - This is pretty gross code. Need to find a better solution
        var _parent = __BentoFindScrollElement(_element.BENTO_VARS.__parent);
        if (BentoExists(_parent))
        {
            with(_parent.BENTO_VARS)
            {
                if (__scrollHori)
                {
                    var _instL = _element.bentoLeft  - BENTO_SCROLL_TO_PADDING;
                    var _instR = _element.bentoRight + BENTO_SCROLL_TO_PADDING;
                    
                    if (__scissorEnabled)
                    {
                        var _parL = _parent.bentoLeft  + __scissorPadLeft  + __scissorScrollbarLeft;
                        var _parR = _parent.bentoRight - __scissorPadRight + __scissorScrollbarRight;
                    }
                    else
                    {
                        var _parL = _parent.bentoLeft;
                        var _parR = _parent.bentoRight;
                    }
                    
                    if (_instR - _instL > _parR - _parL) return true;
                }
                
                if (__scrollVert)
                {
                    var _instT = _element.bentoTop    - BENTO_SCROLL_TO_PADDING;
                    var _instB = _element.bentoBottom + BENTO_SCROLL_TO_PADDING;
                    
                    if (__scissorEnabled)
                    {
                        var _parT = _parent.bentoTop    + __scissorPadTop    + __scissorScrollbarTop;
                        var _parB = _parent.bentoBottom - __scissorPadBottom - __scissorScrollbarBottom;
                    }
                    else
                    {
                        var _parT = _parent.bentoTop;
                        var _parB = _parent.bentoBottom;
                    }
                    
                    if (_instB - _instT > _parB - _parT) return true;
                }
            }
        }
        
        return false;
    }
}