// Feather disable all

function TestContextMenu()
{
    var _json = [
        {
            object: oBentoExButton,
            offset: [200, 10],
            vars: {
                image_blend: c_blue,
            },
        },
        {
            object: oBentoExButton,
            offset: [10, 10],
            vars: {
                image_blend: c_red,
                func: function()
                {
                    BentoCreateFromJSON({
                        object: oBentoExContextMenu,
                        layout: {
                            size: [200, 300],
                            clampInside: true,
                        },
                        children: [
                            {
                                object: oBentoExButton,
                            },
                            {
                                object: oBentoExButton,
                            },
                            {
                                object: oBentoExButton,
                            },
                            {
                                object: oBentoExButton,
                            },
                        ],
                    });
                },
            },
        },
    ];
    
    gridElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
}