// Feather disable all

event_inherited();

// Block lower priority Gui instances from receiving input.
GuiSetBehavior(GUI_BEHAVIOR_MODAL);

// You can hardcode the width and height. It's legal.
width  = 400;
height = 120;

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

GuiLayoutFinish(_layout, x, y + height/2 - 10);

// In this case, we want to select the "Cancel" button by default and we can do so by calling
// `GuiLayoutNavSelect()` and targeting the correct member instance.
GuiLayoutNavSelect(_layout, 1);