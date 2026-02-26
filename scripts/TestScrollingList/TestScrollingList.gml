// Feather disable all

function TestScrollingList()
{
    var _json = [
        {
            object: oBentoExButton,
            vars: {
                image_blend: c_red,
            },
            layout: {
                offset: [10, 10],
            }
        },
        {
            object: oBentoExButton,
            vars: {
                image_blend: c_lime,
            },
            layout: {
                offset: [100, 10],
            }
        },
        {
            object: oBentoExScrollingList,
            vars: {
                image_blend: c_navy,
            },
            layout: {
                offset:  [300, 200],
                size:    [200, 120],
                maxSize: [200, 295],
                resize:  [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                padding: 10,
                gutter:  10,
            },
            children: function(_metadata) {
                //Create identical copies of references to the same struct
                //This is purely for demonstration purposes; real code would do this differently
                return array_create_ext(_metadata.count, function(_index)
                {
                    return {
                        object: oBentoExButton,
                        vars: {
                            image_blend: c_blue,
                            text: string(_index),
                        },
                    };
                });
            },
        },
    ];
    
    gridElement = BentoCreateFromJSON(_json, { count: 11 }, BentoGetRoot());
}