// Feather disable all

GuiInputConfigureNavigation(10, 9, 4, 5);

//with(GuiCreate(oGuiLibList, undefined, GUI_ROOT))
//{
//    image_blend = c_navy;
//    
//    GuiLayoutSetListAxis(0);
//    GuiLayoutSetSize(600, 200);
//    GuiLayoutSetResizeType(GUI_RESIZE_FIT, GUI_RESIZE_FIT);
//    GuiLayoutSetPadding(10, 10, 10, 10);
//    GuiLayoutSetGutter(10, 10);
//    
//    with(GuiCreate(oGuiLibList))
//    {
//        image_blend = c_red;
//        GuiLayoutSetSize(100, 100);
//    }
//    
//    with(GuiCreate(oGuiLibList))
//    {
//        image_blend = c_yellow;
//        GuiLayoutSetSize(100, 100);
//        GuiLayoutSetResizeType(GUI_RESIZE_GROW, GUI_RESIZE_GROW);
//    }
//    
//    with(GuiCreate(oGuiLibList))
//    {
//        image_blend = c_yellow;
//        GuiLayoutSetSize(100, 100);
//        GuiLayoutSetResizeType(GUI_RESIZE_GROW, GUI_RESIZE_GROW);
//    }
//    
//    with(GuiCreate(oGuiLibList))
//    {
//        image_blend = c_blue;
//        GuiLayoutSetSize(100, 100);
//    }
//}

//var _json = {
//    object: oGuiLibGrid,
//    vars: {
//        image_blend: c_navy,
//    },
//    layout: {
//        gridSize: [6, 2],
//        size:     [600, 200],
//        resize:   [GUI_RESIZE_FIT, GUI_RESIZE_FIT],
//        padding:  [10, 10, 10, 10],
//        gutter:   [10, 10],
//    },
//    children: function(_metadata) {
//        //Create identical copies of references to the same struct
//        //This is purely for demonstration purposes; real code would do this differently
//        return array_create(_metadata.count, {
//            object: oGuiLibRect,
//            vars: {
//                image_blend: c_blue,
//            },
//            layout: {
//                resize: [GUI_RESIZE_GROW, GUI_RESIZE_GROW],
//            },
//        });
//    },
//};

var _json = {
    object: oGuiLibList,
    name: "list",
    vars: {
        image_blend: c_ltgray,
    },
    layout: {
        size: [450, 200],
        resize: [GUI_RESIZE_FIT, GUI_RESIZE_FIT],
        padding: [10, 10, 10, 10],
        gutter: [10, 10],
        listAxis: "x",
    },
    children: [
        {
            object: oGuiLibRect,
            vars: {
                image_blend: c_gray,
            },
            layout: {
                size: [100, 100],
                resize: [GUI_RESIZE_STATIC, GUI_RESIZE_GROW],
            },
        },
        {
            object: oGuiLibRect,
            vars: {
                image_blend: c_gray,
            },
            layout: {
                size: [200, 100],
                minSize: [50, 0],
                maxSize: [450, undefined],
                resize: [GUI_RESIZE_GROW, GUI_RESIZE_STATIC],
            },
        },
        {
            object: oGuiLibRect,
            vars: {
                image_blend: c_gray,
            },
            layout: {
                size: [100, 200],
            },
        },
    ],
};

gridInstance = GuiCreateViaJSON(_json, GUI_ROOT, { count: 11 });