// Feather disable all

GuiInputConfigureNavigation(10, 9, 4, 5);

//with(GuiCreate(oGuiLibList, undefined, GUI_ROOT))
//{
//    image_blend = c_navy;
//    
//    GuiSetListAxis(0);
//    GuiSetLayoutSize(600, 200);
//    GuiSetLayoutResizeType(GUI_RESIZE_FIT, GUI_RESIZE_FIT);
//    GuiSetLayoutPadding(10, 10, 10, 10);
//    GuiSetLayoutGutter(10, 10);
//    
//    with(GuiCreate(oGuiLibList))
//    {
//        image_blend = c_red;
//        GuiSetLayoutSize(100, 100);
//    }
//    
//    with(GuiCreate(oGuiLibList))
//    {
//        image_blend = c_yellow;
//        GuiSetLayoutSize(100, 100);
//        GuiSetLayoutResizeType(GUI_RESIZE_GROW, GUI_RESIZE_GROW);
//    }
//    
//    with(GuiCreate(oGuiLibList))
//    {
//        image_blend = c_yellow;
//        GuiSetLayoutSize(100, 100);
//        GuiSetLayoutResizeType(GUI_RESIZE_GROW, GUI_RESIZE_GROW);
//    }
//    
//    with(GuiCreate(oGuiLibList))
//    {
//        image_blend = c_blue;
//        GuiSetLayoutSize(100, 100);
//    }
//}

gridInstance = GuiCreate(oGuiLibGrid, undefined, GUI_ROOT);
with(gridInstance)
{
    image_blend = c_navy;
    
    GuiSetGridSize(6, 2);
    GuiSetLayoutSize(600, 200);
    GuiSetLayoutResizeType(GUI_RESIZE_FIT, GUI_RESIZE_FIT);
    GuiSetLayoutPadding(10, 10, 10, 10);
    GuiSetLayoutGutter(10, 10);
    
    repeat(11)
    {
        with(GuiCreate(oGuiLibRect))
        {
            image_blend = c_blue;
            GuiSetLayoutResizeType(GUI_RESIZE_GROW, GUI_RESIZE_GROW);
        }
    }
}