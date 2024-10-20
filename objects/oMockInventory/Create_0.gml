// Feather disable all

event_inherited();

GuiNameSetSingleton(id, "pause menu page");
GuiSetBehavior(GUI_BEHAVIOR_MODAL);

width = 300;
height = 450;

GuiCreateOutside(GuiExampleButton,
{
    text: "Back",
    func: function()
    {
        GuiDestroy(GuiGetParent());
    },
},
id, x + width/2, y + height/2);