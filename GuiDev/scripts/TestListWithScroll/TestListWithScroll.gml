// Feather disable all

function TestListWithScroll()
{
    var _json = [
        {
            object: oExampleButton,
            vars: {
                image_blend: c_red,
            },
            layout: {
                offset: [10, 10],
            }
        },
        {
            object: oExampleButton,
            vars: {
                image_blend: c_lime,
            },
            layout: {
                offset: [100, 10],
            }
        },
        {
            object: oExampleListWithScroll,
            vars: {
                image_blend: c_navy,
            },
            layout: {
                offset:  [300, 200],
                size:    [200, 120],
                maxSize: [200, 295],
                resize:  [GUI_RESIZE_FIT, GUI_RESIZE_FIT],
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
    
    gridInstance = GuiCreateFromJSON(_json, GUI_ROOT, { count: 11 });
}