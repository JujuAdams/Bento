// Feather disable all

/// Sets the conditions under which child elements for the given parent element will be *not*
/// be hoverable. Any non-hoverable child element is called "enclosed". The enclose type must be
/// one of the `GUI_ENCLOSE_*` macros.
/// 
/// @param encloseType
/// @parma [element=self]

function BentoFocusSetEnclose(_encloseType, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__focusEncloseType != _encloseType)
        {
            __focusEncloseType = _encloseType;
            
            //Enclosure affects
            with(__layer)
            {
                //FIXME - Enclosure should affect Step event execution too maybe? At the very least, there should be
                //        a public getter (`BentoGetEnclosed()` or `BentoGetClickable()` or both)
                __dirtyFlags |= __GUI_DIRTY_STEP | __GUI_DIRTY_HOVERABLE;
            }
        }
    }
}