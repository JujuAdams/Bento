// Feather disable all

function TestShrinkAndGrow()
{
    with(GuiCreateObject(oGuiLibList, undefined, GuiGetRoot()))
    {
        image_blend = c_navy;
        
        GuiLayoutSetList(GUI_AXIS_X, fa_left, fa_top);
        GuiLayoutSetSize(600, 200);
        GuiLayoutSetResizeType(GUI_RESIZE_SHRINK, GUI_RESIZE_SHRINK);
        GuiLayoutSetPadding(10, 10, 10, 10);
        GuiLayoutSetGutter(10, 10);
        
        with(GuiCreateObject(oGuiLibList))
        {
            image_blend = c_red;
            GuiLayoutSetSize(100, 100);
        }
        
        with(GuiCreateObject(oGuiLibList))
        {
            image_blend = c_yellow;
            GuiLayoutSetSize(100, 50);
            GuiLayoutSetResizeType(GUI_RESIZE_GROW, GUI_RESIZE_GROW);
        }
        
        with(GuiCreateObject(oGuiLibList))
        {
            image_blend = c_yellow;
            GuiLayoutSetSize(100, 100);
            GuiLayoutSetResizeType(GUI_RESIZE_GROW, GUI_RESIZE_GROW);
        }
        
        with(GuiCreateObject(oGuiLibList))
        {
            image_blend = c_blue;
            GuiLayoutSetSize(100, 100);
        }
    }
}