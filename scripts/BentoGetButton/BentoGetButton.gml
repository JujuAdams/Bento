// Feather disable all

/// Returns the button type for the element. If the element doesn't exist, this function will
/// return `BENTO_BUTTON_NEVER`. The returned value will be one of the following constants:
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
/// @param [element=self]

function BentoGetButton(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__buttonType : BENTO_BUTTON_NEVER;
}