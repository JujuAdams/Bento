// Feather disable all

function TestAnchor()
{
    var _json = {
        object: oBentoSprite,
        name: "list",
        vars: {
            image_blend: c_ltgray,
        },
        layout: {
            anchor: [1, 0.5],
            size: [450, 200],
            resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
            padding: 10,
            gutter:  10,
            list: ["x", 0, 0],
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
                    resize: [BENTO_RESIZE_NORMAL, BENTO_RESIZE_INFLATE],
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
                            anchor: [0.5, 0],
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
                    resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_NORMAL],
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
    
    anchorElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
}