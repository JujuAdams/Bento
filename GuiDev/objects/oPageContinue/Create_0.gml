// Feather disable all

// Simple set of buttons wrapped in a frame. See `oPageMainMenu` for detailed comments.

event_inherited();

var _layout = GuiLayoutStartListV(id, true, 10, fa_center, fa_middle);

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Slot 1",
    func: function()
    {
        GuiNameDestroy("main menu");
        GuiDestroy(GuiGetParent());
        GuiCreateOutside(oPagePauseMenu, un, GUI_ROOT);
    },
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Slot 2",
    func: function()
    {
        GuiNameDestroy("main menu");
        GuiDestroy(GuiGetParent());
        GuiCreateOutside(oPagePauseMenu, un, GUI_ROOT);
    },
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Slot 3",
    func: function()
    {
        GuiNameDestroy("main menu");
        GuiDestroy(GuiGetParent());
        GuiCreateOutside(oPagePauseMenu, un, GUI_ROOT);
    },
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Back",
    func: function()
    {
        GuiDestroy(GuiGetParent());
    },
});

GuiLayoutFinish(_layout, x, y);
GuiLayoutNavSelectFirst(_layout);
GuiSetSizeAroundChildren(10);