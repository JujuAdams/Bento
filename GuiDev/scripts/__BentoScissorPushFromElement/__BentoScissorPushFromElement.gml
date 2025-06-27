// Feather disable all

function __BentoScissorPushFromElement()
{
    with(GUI_VARS)
    {
        __BentoScissorPush(other.guiLeft   + __scissorPadLeft   + __scissorScrollbarLeft,
                         other.guiTop    + __scissorPadTop    + __scissorScrollbarTop,
                         other.guiRight  - __scissorPadRight  - __scissorScrollbarRight,
                         other.guiBottom - __scissorPadBottom - __scissorScrollbarBottom);
    }
}