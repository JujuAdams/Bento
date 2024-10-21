// Feather disable all

event_inherited();

GuiSetBehavior(GUI_BEHAVIOR_BLOCK_SIBLINGS);
GuiSetPriorityAbove(id, GuiNameFind("main menu"));

var _layout = GuiLayoutStartListV(id, true, 10, fa_center, fa_middle);

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Slot 1",
    func: function()
    {
        GuiNameDestroy("main menu");
        GuiDestroy(GuiGetParent());
        GuiCreateOutside(oMockPauseMenu);
    },
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Slot 2",
    func: function()
    {
        GuiNameDestroy("main menu");
        GuiDestroy(GuiGetParent());
        GuiCreateOutside(oMockPauseMenu);
    },
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Slot 3",
    func: function()
    {
        GuiNameDestroy("main menu");
        GuiDestroy(GuiGetParent());
        GuiCreateOutside(oMockPauseMenu);
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

var _layoutWidth  = GuiLayoutGetWidth(_layout);
var _layoutHeight = GuiLayoutGetHeight(_layout);

GuiLayoutFinish(_layout, x, y);
GuiLayoutNavSelectFirst(_layout);

width  = _layoutWidth + 20;
height = _layoutHeight + 20;