// Feather disable all

function __GuiStepMethodScissorPush()
{
    var _guiStruct = GUI_VARS;
    __GuiScissorPush(guiLeft   + _guiStruct.__scissorPadLeft,
                     guiTop    + _guiStruct.__scissorPadTop,
                     guiRight  - _guiStruct.__scissorPadRight,
                     guiBottom - _guiStruct.__scissorPadBottom);
}