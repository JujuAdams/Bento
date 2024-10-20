// Feather disable all

event_inherited();

GuiSetBehavior(GUI_BEHAVIOR_MODAL);

width  = 400;
height = 120;

var _layout = GuiLayoutStartListH(id, true, 10, fa_center, fa_bottom);

GuiCreateInLayout(_layout, GuiExampleButton, {
    text: "Confirm",
    func: function()
    {
        GuiDestroy(oMockPauseMenu);
        GuiCreateOutside(oMockMainMenu, un, un, room_width/2, 500);
    },
});

GuiCreateInLayout(_layout, GuiExampleButton, {
    text: "Cancel",
    func: function()
    {
        GuiDestroy(GuiGetParent());
    },
});

GuiLayoutFinish(_layout, x, y + height/2 - 10);
GuiLayoutNavSelect(_layout, 1);