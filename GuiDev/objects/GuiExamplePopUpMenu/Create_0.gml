// Feather disable all

event_inherited();

GuiSetBehavior(GUI_BEHAVIOR_POP_UP);

var _layout = GuiLayoutStartListV(id, true, 0, fa_center, fa_top);

var _i = 0;
repeat(array_length(buttonsArray))
{
    var _buttonData = buttonsArray[_i];
    var _instance = GuiCreateInLayout(_layout, GuiExampleButton,
    {
        text: _buttonData.text,
        func: _buttonData.func,
    });
    
    ++_i;
}

GuiLayoutFinish(_layout, x, y);
GuiLayoutSetMembersWidth(_layout, GuiLayoutGetMembersMaxWidth(_layout));
GuiSetSizeAroundChildren(10);