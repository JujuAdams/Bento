// Feather disable all

event_inherited();

GuiTabSetupHost(id);

var _layout = GuiLayoutStartListV(id, true, 10, fa_left, fa_top);

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Inventory",
    func: function()
    {
        GuiTabOpen(GuiCreateOutside(oMockInventory, un, GuiGetParent(), 300, 300));
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
        GuiTabOpen(GuiCreateOutside(oMockOptions, un, GuiGetParent(), 300, 300));
    },
});

GuiLayoutFinish(_layout, x, y + 70);
GuiLayoutNavSelectFirst(_layout);
GuiLayoutTabs(_layout);