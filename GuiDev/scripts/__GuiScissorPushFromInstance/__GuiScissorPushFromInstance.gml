// Feather disable all

function __GuiScissorPushFromInstance()
{
    //TODO - Check these values are accurate
    var _guiStruct = GUI_STRUCT;
    __GuiScissorPush(guiLeft   + _guiStruct.__scissorPadLeft,
                     guiTop    + _guiStruct.__scissorPadTop,
                     guiRight  - _guiStruct.__scissorPadRight,
                     guiBottom - _guiStruct.__scissorPadBottom);
}