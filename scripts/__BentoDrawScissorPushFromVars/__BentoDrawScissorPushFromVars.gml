// Feather disable all

function __BentoDrawScissorPushFromVars()
{
    //TODO - Pass the current scissor element into child elements so we can draw highlights more efficiently
    var _element = __attachedElement;
    __BentoDrawScissorPush(_element.bentoLeft   + __transformOffsetX + __scissorPadLeft   + __scissorScrollbarLeft,
                           _element.bentoTop    + __transformOffsetY + __scissorPadTop    + __scissorScrollbarTop,
                           _element.bentoRight  + __transformOffsetX - __scissorPadRight  - __scissorScrollbarRight,
                           _element.bentoBottom + __transformOffsetY - __scissorPadBottom - __scissorScrollbarBottom);
}