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

var _json = {
    object: oGuiLibGrid,
    vars: {
        image_blend: c_navy,
    },
    layout: {
        gridSize: [6, 2],
        size:     [600, 200],
        resize:   [GUI_RESIZE_FIT, GUI_RESIZE_FIT],
        padding:  [10, 10, 10, 10],
        gutter:   [10, 10],
    },
    children: function(_metadata) {
        //Create identical copies of references to the same struct
        //This is purely for demonstration purposes; real code would do this differently
        return array_create(_metadata.count, {
            object: oGuiLibRect,
            vars: {
                image_blend: c_blue,
            },
            layout: {
                resize: [GUI_RESIZE_GROW, GUI_RESIZE_GROW],
            },
        });
    },
};

gridInstance = GuiCreateViaJSON(_json, GUI_ROOT, { count: 11 });