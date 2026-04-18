// Feather disable all

function TestTransform()
{
    var _json = [
        {
            object: oTestGridWithRotation,
            offset: [30, 30],
            layout: {
                size:    [300, 300],
                padding: 10,
                gutter:  10,
                grid:    [2, 2],
            },
            children: [
                {
                    object: oBentoExSprite,
                    vars: {
                        image_blend: c_red,
                    },
                    layout: {
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                    },
                },
                {
                    object: oBentoExSprite,
                    vars: {
                        image_blend: c_lime,
                    },
                    layout: {
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                    },
                },
                {
                    object: oBentoExSprite,
                    vars: {
                        image_blend: c_blue,
                    },
                    layout: {
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                    },
                },
                {
                    object: oBentoExSprite,
                    vars: {
                        image_blend: c_yellow,
                    },
                    layout: {
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                    },
                },
            ],
        },
    ];
    
    gridElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
}