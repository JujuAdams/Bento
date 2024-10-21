// Feather disable all

event_inherited();

GuiNameSingleton("pause menu page");

width = 300;
height = 450;

var _layout = GuiLayoutStartGridH(id, true, 10, 80, 40, 4);

repeat(30)
{
    GuiCreateInLayout(_layout, GuiExampleButton, {
        width: 80,
        height: 40,
    });
}

GuiLayoutFinish(_layout, GuiGetLeft()+10, GuiGetTop()+10);

GuiSetSizeAroundLayout(_layout, 10);

GuiCreateOutside(GuiExampleButton,
{
    text: "Back",
    func: function()
    {
        GuiDestroy(GuiGetParent());
    },
},
id, x + width/2, y + height/2);