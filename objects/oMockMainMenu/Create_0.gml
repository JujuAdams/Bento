// Feather disable all

event_inherited();

GuiNameSetSingleton(id, "main menu");
GuiTabSetupHost();

var _layout = GuiLayoutStartListV(id, true, 10, fa_left, fa_middle);

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Continue Adventure",
    func: function()
    {
        GuiTabOpen(GuiCreateOutside(oMockContinue, un, GuiGetParent(2), room_width/2, 500));
    },
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Start Adventure",
    func: function()
    {
        GuiDestroyByName("main menu");
        GuiCreateOutside(oMockPauseMenu);
    },
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Options",
    func: function()
    {
        var _instance = GuiCreateOutside(oMockOptions, un, GuiGetParent(2), room_width/2, 500);
        GuiSetBehavior(_instance, GUI_BEHAVIOR_BLOCK_SIBLINGS);
        GuiSetPriorityTop(_instance);
        GuiTabOpen(_instance);
    },
});

var _layoutWidth  = GuiLayoutGetWidth(_layout);
var _layoutHeight = GuiLayoutGetHeight(_layout);

GuiLayoutFinish(_layout, x - _layoutWidth/2, y);
GuiLayoutTabs(_layout);
GuiLayoutNavSelect(_layout);

width  = _layoutWidth + 20;
height = _layoutHeight + 20;