// Feather disable all

function __BentoScissorPushFromVars()
{
    var _element = __attachedElement;
    __BentoScissorPush(_element.bentoLeft   + __scissorPadLeft   + __scissorScrollbarLeft,
                       _element.bentoTop    + __scissorPadTop    + __scissorScrollbarTop,
                       _element.bentoRight  - __scissorPadRight  - __scissorScrollbarRight,
                       _element.bentoBottom - __scissorPadBottom - __scissorScrollbarBottom);
}