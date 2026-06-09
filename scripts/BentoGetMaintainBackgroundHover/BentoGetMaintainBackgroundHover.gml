// Feather disable all

/// Returns the backgrounded hover mode for an element. This value can be changed by calling
/// `BentoSetMaintainBackgroundHover()`. The default value is `BENTO_MAINTAIN_DIRECTION`. If the
/// given element doesn't exist then this function will return `BENTO_MAINTAIN_NEVER`.
/// 
/// @param [element=self]

function BentoGetMaintainBackgroundHover(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__backgroundHover : BENTO_MAINTAIN_NEVER;
}