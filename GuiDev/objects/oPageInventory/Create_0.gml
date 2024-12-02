// Feather disable all

event_inherited();

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
    var _button = GuiCreateInLayout(_layout, GuiExampleButton);
    GuiSetSize(80, 40, _button);
}

GuiLayoutFinish(_layout, 0, _sortButton.bbox_bottom + 10);

GuiSetSizeAroundChildren(10);

var _button = GuiCreateOutside(GuiExampleButtonEllipse,
{
    text: "Back",
    func: function()
    {
        GuiDestroy(GuiGetParent());
    },
});
GuiSetPosition(bbox_right, bbox_bottom + 7, _button, fa_center, fa_middle);

GuiSetPosition(display_get_gui_width()/2, display_get_gui_height()/2, id, fa_center, fa_middle);
GuiLayoutNavSelectFirst(_layout);