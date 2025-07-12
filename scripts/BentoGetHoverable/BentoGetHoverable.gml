// Feather disable all

/// Returns whether an element is hoverable (i.e. its "hover" state can be set by Bento).
/// 
/// @param [element=self]
/// @param [checkVisible=true]

function BentoGetHoverable(_element = self, _checkVisible = true)
{
    return __BentoGetHoverableInternal(_element, _checkVisible);
}

function __BentoGetHoverableInternal(_element, _checkVisible)
{
    with(__BentoGetVars(_element))
    {
        //Can't hover invisible elements
        if (not __visible) return false;
        
        //Can't hover anything if the layer has any blocking animations
        if (not ds_map_empty(__layer.__animBlockingMap)) return false;
        
        //Can't hover elements that aren't in the most recent hoverable order array
        if (__hoverableIndex != __layer.__hoverableRegenCount) return false;
        
        //Can't hover anything that's outside a clipping region
        return ((not _checkVisible) || (__scissorVisibility != BENTO_VISIBLE_NONE));
    }
    
    return false;
}