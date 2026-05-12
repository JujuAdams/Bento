// Feather disable all

/// Sets the button type for the element. The button type should be one of the following constants:
/// 
/// `BENTO_BUTTON_NEVER`
///     Not a button. Cannot be clicked and cannot be hovered in navigation input modes.
/// 
/// `BENTO_BUTTON_ALWAYS`
///     Always hoverable and clickable in any input mode.
/// 
/// `BENTO_BUTTON_POINTER`
///     Only a button in pointer input modes. Cannot be hovered in navigation input modes.
/// 
/// `BENTO_BUTTON_NAVIGATION`
///     Only a button in navigation input modes. Cannot be clicked in pointer input modes.
/// 
/// @param buttonType
/// @param [element=self]

function BentoSetButton(_buttonType, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__buttonType != _buttonType)
        {
            __buttonType = _buttonType;
            
            //Update data relating to buttons
            __layer.__dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
        }
    }
}