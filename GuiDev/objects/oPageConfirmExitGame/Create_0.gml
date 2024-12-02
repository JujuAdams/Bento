// Feather disable all

event_inherited();

// Block lower priority Gui instances from receiving input.
GuiSetBehavior(GUI_BEHAVIOR_MODAL);

// You can hardcode the width and height. You won't get arrested.
GuiSetSize(400, 120, id, fa_center, fa_middle);

// This is a horizontal list as opposed to a vertical list but it works the same!
var _layout = GuiLayoutStartListH(id, true, 10, fa_center, fa_bottom);

GuiCreateInLayout(_layout, GuiExampleButton, {
    text: "Confirm",
    func: function()
    {
        GuiDestroy(oPagePauseMenu);
        GuiCreateOutside(oPageMainMenu, un, GUI_ROOT, room_width/2, 500);
    },
});

GuiCreateInLayout(_layout, GuiExampleButton, {
    text: "Cancel",
    func: function()
    {
        GuiDestroy(GuiGetParent());
    },
});

GuiLayoutFinish(_layout, GuiGetCenterX(), bbox_bottom - 10);

// In this case, we want to select the "Cancel" button by default and we can do so by calling
// `GuiLayoutNavSelect()` and targeting the correct member instance.
GuiLayoutNavSelect(_layout, 1);