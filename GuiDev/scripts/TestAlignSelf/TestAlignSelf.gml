// Feather disable all

function TestAlignSelf()
{
    var _json = {
        object: oGuiLibList,
        name: "list",
        vars: {
            image_blend: c_ltgray,
        },
        layout: {
            alignSelf: [1, 0.5],
            size: [450, 200],
            resize: [GUI_RESIZE_FIT, GUI_RESIZE_FIT],
            padding: [10, 10, 10, 10],
            gutter: [10, 10],
            listAxis: "x",
        },
        children: [
            {
                object: oGuiLibRect,
                name: "first",
                vars: {
                    image_blend: c_gray,
                },
                layout: {
                    size: [100, 100],
                    resize: [GUI_RESIZE_STATIC, GUI_RESIZE_GROW],
                },
                children: [
                    {
                        object: oGuiLibRect,
                        name: "second",
                        vars: {
                            image_blend: c_dkgray,
                        },
                        layout: {
                            size: [20, 20],
                            alignSelf: [0, 0],
                        },
                    },
                ],
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
    
    gridElement = GuiCreateFromJSON(_json, GUI_ROOT, { count: 11 });
}