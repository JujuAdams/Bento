// Feather disable all

// Juju: This is an example of a sidebar-based pause menu. You can see full and detailed comments
//       regarding pages in `oPageMainMenu`.

event_inherited();

// Set up a tab group for buttons on the sidebar. The second parameter for this function allows
// us to block selection of tab buttons in this tab group whilst a child of the tab group is open.
// This makes directional navigation much less clumsy. However, if the player is using a pointer
// (mouse or touch input) then the tabs are freely selectable for convenience.
GuiTabSetupHost("pause menu tabs", true);

var _layout = GuiLayoutStartListV(id, true, 10, fa_left, fa_top);

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Inventory",
    func: function()
    {
        GuiTabOpen(GuiCreateOutside(oPageInventory, un, GuiGetParent(), 300, 300));
    },
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Equipment",
    func: function() {},
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Magic/Heal",
    func: function() {},
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Status",
    func: function() {},
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Options",
    func: function()
    {
        GuiTabOpen(GuiCreateOutside(oPageOptions, un, GuiGetParent(), 300, 300));
    },
});

GuiLayoutFinish(_layout, x, y + 70);
GuiLayoutNavSelectFirst(_layout);
GuiLayoutMembersSetupTabButton(_layout, "pause menu tabs");

// Sets the width of members of a layout, but only if they're instances of a particular object.
// This allows us to selectively control the size of particular parts of a layout.
GuiLayoutSetMembersWidthExt(_layout, GuiLayoutGetMembersMaxWidth(_layout), GuiExampleButton);