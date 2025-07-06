// Feather disable all

function TestScrollboxWithBar()
{
    var _json = [
        {
            object: oExampleScrollboxWithBar,
            vars: {
                image_blend: c_maroon,
            },
            offset: [300, 200],
            layout: {
                size:    [200, 120],
                maxSize: [200, 295],
                resize:  [BENTO_RESIZE_SHRINK, BENTO_RESIZE_STATIC],
                padding: 10,
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
    
    scrollboxElement = BentoCreateFromJSON(_json, { count: 11 }, BentoGetRoot());
}