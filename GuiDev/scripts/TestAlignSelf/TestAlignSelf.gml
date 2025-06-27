// Feather disable all

function TestAlignSelf()
{
    var _json = {
        object: oBentoList,
        name: "list",
        vars: {
            image_blend: c_ltgray,
        },
        layout: {
            alignSelf: [1, 0.5],
            size: [450, 200],
            resize: [BENTO_RESIZE_SHRINK, BENTO_RESIZE_SHRINK],
            padding: [10, 10, 10, 10],
            gutter: [10, 10],
            listAxis: "x",
        },
        children: [
            {
                object: oBentoSprite,
                name: "first",
                vars: {
                    image_blend: c_gray,
                },
                layout: {
                    size: [100, 100],
                    resize: [BENTO_RESIZE_STATIC, BENTO_RESIZE_EXPAND],
                },
                children: [
                    {
                        object: oBentoSprite,
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
                object: oBentoSprite,
                vars: {
                    image_blend: c_gray,
                },
                layout: {
                    size: [200, 100],
                    minSize: [50, 0],
                    maxSize: [450, undefined],
                    resize: [BENTO_RESIZE_EXPAND, BENTO_RESIZE_STATIC],
                },
            },
            {
                object: oBentoSprite,
                vars: {
                    image_blend: c_gray,
                },
                layout: {
                    size: [100, 200],
                },
            },
        ],
    };
    
    gridElement = BentoCreateFromJSON(_json, { count: 11 }, BentoGetRoot());
}