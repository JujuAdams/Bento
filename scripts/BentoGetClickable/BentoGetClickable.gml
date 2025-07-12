// Feather disable all

/// Returns whether an element is clickable (i.e. `BentoPrimaryGetClick()` can return `true`).
/// 
/// @param [element=self]

function BentoGetClickable(_element = self)
{
    with(__BentoGetVars(_element))
    {
        //Can't click invisible elements
        if (not __visible) return false;
        
        //Can't click it if you can't hover it
        if (__hoverableIndex != __layer.__hoverableRegenCount) return false;
        
        //Can't click anything that's outside a clipping region
        if (__scissorVisibility == BENTO_VISIBLE_NONE) return false;
        
        //Can only click it if the button type matches the input mode
        return (__buttonType & (__layer.__navPointer? BENTO_BUTTON_POINTER : BENTO_BUTTON_DIRECTIONAL));
    }
    
    return false;
}