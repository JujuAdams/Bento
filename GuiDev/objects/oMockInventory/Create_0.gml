// Feather disable all

event_inherited();

GuiNameSingleton("pause menu page");

var _sortButton = GuiCreateInside(GuiExampleButton,
{
    text: "Sort",
    func: function()
    {
        GuiCreateOutside(GuiExamplePopUpMenu,
        {
            buttonsArray: [
                {
                    text: "Name",
                    func: function()
                    {
                        GuiDestroy(GuiGetParent());
                    },
                },
                {
                    text: "Type",
                    func: function()
                    {
                        GuiDestroy(GuiGetParent());
                    },
                },
                {
                    text: "Value",
                    func: function()
                    {
                        GuiDestroy(GuiGetParent());
                    },
                },
            ],
        },
        GuiGetParent(), GuiNavGetCursorX(), GuiNavGetCursorY());
    },
});

GuiSetPosition(0, 0, _sortButton, fa_left, fa_top);

var _layout = GuiLayoutStartGridH(id, true, 10, 80, 40, 4);

repeat(30)
{
    GuiCreateInLayout(_layout, GuiExampleButton, {
        width: 80,
        height: 40,
    });
}

GuiLayoutFinish(_layout, 0, GuiGetBottom(_sortButton) + 10);

GuiSetSizeAroundChildren(10);

GuiCreateOutside(GuiExampleButton,
{
    text: "Back",
    func: function()
    {
        GuiDestroy(GuiGetParent());
    },
},
id, GuiGetRight(), GuiGetBottom() + 7);

GuiSetPosition(display_get_gui_width()/2, display_get_gui_height()/2);
GuiLayoutNavSelectFirst(_layout);