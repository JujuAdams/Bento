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
            resize: [GUI_RESIZE_SHRINK, GUI_RESIZE_SHRINK],
            padding: [10, 10, 10, 10],
            gutter: [10, 10],
            listAxis: "x",
        },
        children: [
            {
                object: oGuiLibSprite,
                name: "first",
                vars: {
                    image_blend: c_gray,
                },
                layout: {
                    size: [100, 100],
                    resize: [GUI_RESIZE_STATIC, GUI_RESIZE_EXPAND],
                },
                children: [
                    {
                        object: oGuiLibSprite,
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
                object: oGuiLibSprite,
                vars: {
                    image_blend: c_gray,
                },
                layout: {
                    size: [200, 100],
                    minSize: [50, 0],
                    maxSize: [450, undefined],
                    resize: [GUI_RESIZE_EXPAND, GUI_RESIZE_STATIC],
                },
            },
            {
                object: oGuiLibSprite,
                vars: {
                    image_blend: c_gray,
                },
                layout: {
                    size: [100, 200],
                },
            },
        ],
    };
    
    gridElement = GuiCreateFromJSON(_json, GuiGetRoot(), { count: 11 });
}