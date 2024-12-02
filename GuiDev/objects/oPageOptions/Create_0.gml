// Feather disable all

event_inherited();

// This layout is another vertical list but creates a bunch of atypical Gui instances that the
// player can fiddle with. For more information on layouts please see `oPageMainMenu`.
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

// We don't want to create the "Exit Game" button if we're on the main menu.
if (not GuiNameExists("main menu"))
{
    GuiCreateInLayout(_layout, GuiExampleButton,
    {
        text: "Exit Game",
        func: function()
        {
            var _instance = GuiCreateOutside(oPageConfirmExitGame, un, GuiGetParent(), room_width/2, room_height/2);
            GuiNavSelectOnDestroy(_instance, id);
        },
    });
}

// Adapt the width of the options menu depending on the width of the widest child instance but
// limit the height (mostly to demonstrate the scrolling behaviour).
GuiSetSize(GuiLayoutGetMembersMaxWidth(_layout) + 20, 250, id, fa_center, fa_middle);

// Create the scrollbox region. This will, by default, up the position and size of the scoped
// instance as the basis for the region.
GuiScrollSetRegion();

// Finish the layout, which positions the member instances. This particular function also sets up
// the scroll limits using the member instances as a guide for how far the scrolling should go.
GuiLayoutFinishWithScroll(_layout);

// Make sure the directional navigation selects something valid.
GuiLayoutNavSelectFirst(_layout);

// Separate to the scrollbox and the layout, we also need to create a "Back" button so the player
// can dismiss this page.
var _button = GuiCreateOutside(GuiExampleButtonDiamond,
{
    text: "Back",
    func: function()
    {
        // Because the parent (`oPageOptions`) is created as a child of a tab group, destroying
        // the parent will revert control to the tab button that created the parent. On the pause
        // menu, this is one of the buttons in the sidebar. On the main menu, this is a main menu
        // button.
        GuiDestroy(GuiGetParent());
    },
});
GuiSetPosition(bbox_right, bbox_bottom + 7, _button, fa_center, fa_middle);