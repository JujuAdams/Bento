// Feather disable all

function TestGrid()
{
    var _json = {
        object: oBentoExGrid,
        vars: {
            image_blend: c_navy,
        },
        layout: {
            grid:    [6, 2],
            size:    [600, 200],
            resize:  [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
            padding: [10, 10, 10, 10],
            gutter:  [10, 10],
        },
        children: function(_metadata) {
            //Create identical copies of references to the same struct
            //This is purely for demonstration purposes; real code would do this differently
            return array_create(_metadata.count, {
                object: oBentoExButton,
                vars: {
                    image_blend: c_blue,
                },
                layout: {
                    resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                },
            });
        },
    };
    
    gridElement = BentoCreateFromJSON(_json, { count: 11 }, BentoLayerGetRoot());
}