// Feather disable all

/// Returns whether the element will execute its Step user event / callback.
/// 
/// @param [element=self]

function BentoGetExecutesStep(_element = self)
{
    with(_element)
    {
        //NOTE - This logic must match `__BentoEnsureStepOrderInner()`
        var _layer = __layer;
        var _navType = _layer.__navPointer? BENTO_BUTTON_POINTER : BENTO_BUTTON_DIRECTIONAL;
        return ((not __disable) && (BENTO_ALWAYS_EXECUTE_STEP || (__buttonIndex == _layer.__hoverableRegenCount) || __forceStep || __focused || __scissorEnabled));
    }
    
    return false;
}