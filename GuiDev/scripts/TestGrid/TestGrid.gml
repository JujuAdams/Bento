// Feather disable all

function TestGrid()
{
    var _json = {
        object: oExampleGrid,
        vars: {
            image_blend: c_navy,
        },
        layout: {
            grid:    [6, 2],
            size:    [600, 200],
            resize:  [BENTO_RESIZE_SHRINK, BENTO_RESIZE_SHRINK],
            padding: [10, 10, 10, 10],
            gutter:  [10, 10],
        },
        children: function(_metadata) {
            //Create identical copies of references to the same struct
            //This is purely for demonstration purposes; real code would do this differently
            return array_create(_metadata.count, {
                object: oExampleButton,
                vars: {
                    image_blend: c_blue,
                },
                layout: {
                    resize: [BENTO_RESIZE_EXPAND, BENTO_RESIZE_EXPAND],
                },
            });
        },
    };
    
    gridElement = BentoCreateFromJSON(_json, { count: 11 }, BentoGetRoot());
}