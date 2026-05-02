// Feather disable all

/// Returns the preferred click timing. This will be `BENTO_CLICK_ON_PRESS`, `BENTO_CLICK_ON_RELEASE`,
/// or `undefined`.
/// 
/// @param [element=self]

function BentoGetClickTiming(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__clickTiming : undefined;
}