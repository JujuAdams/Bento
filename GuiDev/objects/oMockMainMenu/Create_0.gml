// Feather disable all

event_inherited();

GuiNameSingleton("main menu");
GuiTabSetupHost("main menu");

var _layout = GuiLayoutStartListV(id, true, 10, fa_left, fa_middle);

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Continue Adventure",
    func: function()
    {
        var _instance = GuiCreateOutside(oMockContinue, un, GuiGetParent(2), room_width/2, 500);
        GuiSetBehavior(GUI_BEHAVIOR_BLOCK_SIBLINGS, _instance);
        GuiSetPriorityTop(_instance);
        GuiTabOpen(_instance);
    },
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Start Adventure",
    func: function()
    {
        GuiNameDestroy("main menu");
        GuiCreateOutside(oMockPauseMenu, un, GUI_ROOT);
    },
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Options",
    func: function()
    {
        var _instance = GuiCreateOutside(oMockOptions, un, GuiGetParent(2), room_width/2, 500);
        GuiSetBehavior(GUI_BEHAVIOR_BLOCK_SIBLINGS, _instance);
        GuiSetPriorityTop(_instance);
        GuiTabOpen(_instance);
    },
});

var _layoutWidth  = GuiLayoutGetWidth(_layout);
var _layoutHeight = GuiLayoutGetHeight(_layout);

GuiLayoutFinish(_layout, x - _layoutWidth/2, y);
GuiLayoutMembersSetupTabButton(_layout, "main menu");
GuiLayoutNavSelectFirst(_layout);

width  = _layoutWidth + 20;
height = _layoutHeight + 20;