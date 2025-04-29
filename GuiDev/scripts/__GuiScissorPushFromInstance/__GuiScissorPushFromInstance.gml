// Feather disable all

function __GuiScissorPushFromInstance()
{
    var _guiStruct = GUI_STRUCT;
    __GuiScissorPush(guiLeft   + _guiStruct.__scissorPadLeft,
                     guiTop    + _guiStruct.__scissorPadTop,
                     guiRight  - _guiStruct.__scissorPadRight,
                     guiBottom - _guiStruct.__scissorPadBottom);
}