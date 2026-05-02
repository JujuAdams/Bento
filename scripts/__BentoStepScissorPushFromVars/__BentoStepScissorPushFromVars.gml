// Feather disable all

function __BentoStepScissorPushFromVars()
{
    //TODO - Pass the current scissor element into child elements so we can draw highlights more efficiently
    var _element = __attachedElement;
    __BentoStepScissorPush(_element.bentoLeft   + __scissorPadLeft   + __scissorScrollbarLeft,
                           _element.bentoTop    + __scissorPadTop    + __scissorScrollbarTop,
                           _element.bentoRight  - __scissorPadRight  - __scissorScrollbarRight,
                           _element.bentoBottom - __scissorPadBottom - __scissorScrollbarBottom);
}