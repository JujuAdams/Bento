// Feather disable all

function __GuiScissorPushFromElement()
{
    with(GUI_VARS)
    {
        __GuiScissorPush(other.guiLeft   + __scissorPadLeft   + __scissorScrollbarLeft,
                         other.guiTop    + __scissorPadTop    + __scissorScrollbarTop,
                         other.guiRight  - __scissorPadRight  - __scissorScrollbarRight,
                         other.guiBottom - __scissorPadBottom - __scissorScrollbarBottom);
    }
}