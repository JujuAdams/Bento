// Feather disable all

function TestAlignSelf()
{
    var _json = {
        object: oBentoSprite,
        name: "list",
        vars: {
            image_blend: c_ltgray,
        },
        layout: {
            alignSelf: [1, 0.5],
            size: [450, 200],
            resize: [BENTO_RESIZE_SHRINK, BENTO_RESIZE_SHRINK],
            padding: 10,
            gutter:  10,
            list: ["x", fa_left, fa_top],
        },
        children: [
            {
                object: oBentoSprite,
                name: "first",
                vars: {
                    image_blend: c_red,
                },
                layout: {
                    size: [100, 100],
                    padding: 10,
                    resize: [BENTO_RESIZE_STATIC, BENTO_RESIZE_EXPAND],
                },
                children: [
                    {
                        object: oBentoSprite,
                        name: "second",
                        vars: {
                            image_blend: c_yellow,
                        },
                        layout: {
                            size: [20, 20],
                            alignSelf: [0.5, 0],
                        },
                    },
                ],
            },
            {
                object: oBentoSprite,
                vars: {
                    image_blend: c_lime,
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
                    image_blend: c_blue,
                },
                layout: {
                    size: [100, 200],
                },
            },
        ],
    };
    
    alignSelfElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
}