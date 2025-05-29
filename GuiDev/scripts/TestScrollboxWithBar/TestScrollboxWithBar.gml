// Feather disable all

function TestScrollboxWithBar()
{
    var _json = [
        {
            object: oExampleScrollboxWithBar,
            vars: {
                image_blend: c_maroon,
            },
            layout: {
                offset:  [300, 200],
                size:    [200, 120],
                maxSize: [200, 295],
                resize:  [GUI_RESIZE_SHRINK, GUI_RESIZE_SHRINK],
                padding: 30,
                gutter:  30,
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
    
    gridElement = GuiCreateFromJSON(_json, GuiGetRoot(), { count: 11 });
}