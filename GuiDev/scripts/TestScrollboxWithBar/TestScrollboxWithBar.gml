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
            },
        },
    ];
    
    scrollboxElement = GuiCreateFromJSON(_json, GuiGetRoot());
    
    var _json = array_create_ext(11, function(_index)
    {
        return {
            object: oExampleButton,
            vars: {
                image_blend: c_blue,
                text: string(_index),
            },
        };
    });
    
    GuiCreateFromJSON(_json, scrollboxElement.scrollbox);
}