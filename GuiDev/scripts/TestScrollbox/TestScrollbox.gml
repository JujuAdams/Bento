// Feather disable all

function TestScrollbox()
{
    var _json = [
        {
            object: oExampleScrollbox,
            vars: {
                image_blend: c_maroon,
            },
            layout: {
                offset:  [300, 200],
                size:    [200, 120],
                maxSize: [200, 295],
                resize:  [BENTO_RESIZE_SHRINK, BENTO_RESIZE_SHRINK],
                padding: 10,
                gutter:  10,
            },
            children: function(_metadata) {
                //Create identical copies of references to the same struct
                //This is purely for demonstration purposes; real code would do this differently
                return array_create_ext(_metadata.count, function(_index)
                {
                    return {
                        object: oExampleButton,
                        vars: {
                            image_blend: c_blue,
                            text: string(_index),
                        },
                    };
                });
            },
        },
    ];
    
    scrollboxElement = BentoCreateFromJSON(_json, BentoGetRoot(), { count: 11 });
}