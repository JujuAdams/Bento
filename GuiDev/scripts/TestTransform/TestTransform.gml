// Feather disable all

function TestTransform()
{
    var _json = [
        {
            object: oExampleGridWithRotation,
            layout: {
                offset: [30, 30],
                size: [300, 300],
                padding: 10,
                gutter: 10,
                gridSize: [2, 2],
            },
            children: [
                {
                    object: oBentoSprite,
                    vars: {
                        image_blend: c_red,
                    },
                    layout: {
                        resize: [GUI_RESIZE_EXPAND, GUI_RESIZE_EXPAND],
                    },
                },
                {
                    object: oBentoSprite,
                    vars: {
                        image_blend: c_lime,
                    },
                    layout: {
                        resize: [GUI_RESIZE_EXPAND, GUI_RESIZE_EXPAND],
                    },
                },
                {
                    object: oBentoSprite,
                    vars: {
                        image_blend: c_blue,
                    },
                    layout: {
                        resize: [GUI_RESIZE_EXPAND, GUI_RESIZE_EXPAND],
                    },
                },
                {
                    object: oBentoSprite,
                    vars: {
                        image_blend: c_yellow,
                    },
                    layout: {
                        resize: [GUI_RESIZE_EXPAND, GUI_RESIZE_EXPAND],
                    },
                },
            ],
        },
    ];
    
    gridElement = BentoCreateFromJSON(_json, BentoGetRoot());
}