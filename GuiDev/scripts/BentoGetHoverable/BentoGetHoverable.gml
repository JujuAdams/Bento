// Feather disable all

/// Returns whether an instance is hoverable (i.e. its "over" state can be set).
/// 
/// @param [element=self]
/// @param [checkVisible=true]

function BentoGetHoverable(_element = self, _checkVisible = true)
{
    return __BentoGetHoverableInternal(_element, _checkVisible);
}

function __BentoGetHoverableInternal(_element, _checkVisible)
{
    if (not BentoExists(_element)) return false;
    
    with(_element.BENTO_VARS)
    {
        //Can't hover invisible elements
        if (not __visible) return false;
        
        //Can't hover elements that aren't in the most recent hoverable order array
        if (__hoverableIndex != __layer.__hoverableRegenCount) return false;
        
        //Can't hover anything that's outside a clipping region
        return ((not _checkVisible) || (__scissorVisibility != BENTO_VISIBLE_NONE));
    }
    
    return false;
}