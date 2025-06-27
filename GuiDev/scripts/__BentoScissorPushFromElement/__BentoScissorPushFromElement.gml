// Feather disable all

function __BentoScissorPushFromElement()
{
    with(BENTO_VARS)
    {
        __BentoScissorPush(other.bentoLeft   + __scissorPadLeft   + __scissorScrollbarLeft,
                           other.bentoTop    + __scissorPadTop    + __scissorScrollbarTop,
                           other.bentoRight  - __scissorPadRight  - __scissorScrollbarRight,
                           other.bentoBottom - __scissorPadBottom - __scissorScrollbarBottom);
    }
}