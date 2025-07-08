// Feather disable all

/// Sets the conditions under which child elements for the given parent element will be **not**
/// be hoverable. Any non-hoverable child element is called "enclosed". The enclose type must be
/// one of the following constants:
/// 
/// `BENTO_ENCLOSE_NEVER`
///     Child elements are never enclosed and can always be interacted with.
/// 
/// `BENTO_ENCLOSE_ALWAYS`
///     Child elements are always enclosed and cannot be interacted with unless the parent is
///     focused.
/// 
/// `BENTO_ENCLOSE_DIRECTIONAL`  
///     Child elements are enclosed in directional navigation modes only. Pointer navigation modes
///     will be able to select elements freely. This is useful for scrollboxes.
/// 
/// `BENTO_ENCLOSE_POINTER` 
///     Child elements are enclosed in pointer navigation modes only. Directional navigation modes
///     will be able to select elements freely. This is probably never useful and is provided only
///     for completeness.     
/// 
/// The enclose feature is useful for scrollboxes where you want the contents to be hoverable and
/// clickable when using pointer input but inaccessible when using directional input. In this
/// example, you'd use the enclose type `BENTO_ENCLOSE_DIRECTIONAL` - we want the buttons to
/// be inaccessible when the parent scrollbox is unfocused when using a directional input mode.
/// 
/// @param encloseType
/// @parma [element=self]

function BentoFocusSetEnclose(_encloseType, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__focusEncloseType != _encloseType)
        {
            __focusEncloseType = _encloseType;
            
            //Enclosure affects
            with(__layer)
            {
                //FIXME - Enclosure should affect Step event execution too maybe? At the very least, there should be
                //        a public getter (`BentoGetEnclosed()` or `BentoGetClickable()` or both)
                __dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
            }
        }
    }
}