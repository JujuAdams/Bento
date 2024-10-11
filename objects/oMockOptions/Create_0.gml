// Feather disable all

event_inherited();

GuiNameSetSingleton(id, "pause menu page");
GuiSetBehavior(id, GUI_BEHAVIOR_MODAL);
GuiSetEnableDrawEnd(un, true);

var _layout = GuiLayoutStartListV(id, true, 10, fa_center, fa_top);

GuiCreateInLayout(_layout, GuiExampleCarousel,
{
    title: "Message Speed",
    optionArray: ["Normal", "Fast", "Fastest"],
    option: 0,
    func: function(_index, _optionName) {},
});

GuiCreateInLayout(_layout, GuiExampleScroller,
{
    title: "Music Volume",
    func: function(_value) {},
});

GuiCreateInLayout(_layout, GuiExampleScroller,
{
    title: "Sound Volume",
    func: function(_value) {},
});

GuiCreateInLayout(_layout, GuiExampleCarousel,
{
    title: "Resolution",
    optionArray: ["1920 x 1080", "2560 x 1440"],
    option: 0,
    func: function(_index, _optionArray) {},
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Go Fullscreen",
    func: function() {},
});

if (not GuiNameExists("main menu"))
{
    GuiCreateInLayout(_layout, GuiExampleButton,
    {
        text: "Exit Game",
        func: function()
        {
            var _instance = GuiCreateOutside(oMockConfirmExitGame, un, GuiGetParent(), room_width/2, room_height/2);
            GuiNavSelectOnDestroy(_instance, id);
        },
    });
}

height = 250;

GuiLayoutFinish(_layout, x, y - height/2);
GuiLayoutNavSelect(_layout);

width = GuiLayoutGetMaxWidth(_layout) + 20;

GuiCreateOutside(GuiExampleButton,
{
    text: "Back",
    func: function()
    {
        GuiDestroy(GuiGetParent());
    },
},
id, x + width/2, y + height/2);

GuiScissorSetup(id, x - width/2, y - height/2, x + width/2, y + height/2);
GuiScrollSetup(id, un, un, un, -max(0, GuiLayoutGetHeight(_layout) - height));