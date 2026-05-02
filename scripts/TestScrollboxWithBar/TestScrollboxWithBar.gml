// Feather disable all

function TestListboxWithBar()
{
    var _json = [
        {
            object: oBentoExListboxWithBar,
            vars: {
                image_blend: c_maroon,
            },
            offset: [300, 200],
            layout: {
                size:    [200, 120],
                maxSize: [200, 295],
                resize:  [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_NORMAL],
                padding: 10,
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
    
    scrollboxElement = BentoCreateFromJSON(_json, { count: 11 }, BentoLayerGetRoot());
}