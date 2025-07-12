// Feather disable all

/// Returns whether the element will execute its Step user event / callback.
/// 
/// @param [element=self]

function BentoGetExecutesStep(_element = self)
{
    with(_element)
    {
        //NOTE - This logic must match `__BentoEnsureStepOrderInner()`
        var _navType = __layer.__navPointer? BENTO_BUTTON_POINTER : BENTO_BUTTON_DIRECTIONAL;
        return ((not __disable) && (BENTO_ALWAYS_EXECUTE_STEP || (__buttonType & _navType) || __forceStep || __focused || __scissorEnabled));
    }
    
    return false;
}