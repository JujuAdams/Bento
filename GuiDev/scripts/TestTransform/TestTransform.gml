// Feather disable all

function TestTransform()
{
    var _json = [
        {
            object: oExampleGridWithRotation,
            layout: {
                offset:  [30, 30],
                size:    [300, 300],
                padding: 10,
                gutter:  10,
                grid:    [2, 2],
            },
            children: [
                {
                    object: oBentoSprite,
                    vars: {
                        image_blend: c_red,
                    },
                    layout: {
                        resize: [BENTO_RESIZE_EXPAND, BENTO_RESIZE_EXPAND],
                    },
                },
                {
                    object: oBentoSprite,
                    vars: {
                        image_blend: c_lime,
                    },
                    layout: {
                        resize: [BENTO_RESIZE_EXPAND, BENTO_RESIZE_EXPAND],
                    },
                },
                {
                    object: oBentoSprite,
                    vars: {
                        image_blend: c_blue,
                    },
                    layout: {
                        resize: [BENTO_RESIZE_EXPAND, BENTO_RESIZE_EXPAND],
                    },
                },
                {
                    object: oBentoSprite,
                    vars: {
                        image_blend: c_yellow,
                    },
                    layout: {
                        resize: [BENTO_RESIZE_EXPAND, BENTO_RESIZE_EXPAND],
                    },
                },
            ],
        },
    ];
    
    gridElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
}