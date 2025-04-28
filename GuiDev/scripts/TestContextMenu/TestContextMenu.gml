// Feather disable all

function TestContextMenu()
{
    var _json = [
        {
            object: oExampleButton,
            layout: {
                offset: [10, 10],
            },
            vars: {
                image_blend: c_red,
                clickFunc: function()
                {
                    GuiCreateFromJSON({
                        object: oExampleContextMenu,
                        layout: {
                            size: [200, 300],
                            alignSelf: [1, 1],
                            clampInside: true,
                        },
                        children: [
                            {
                                object: oExampleButton,
                            },
                            {
                                object: oExampleButton,
                            },
                            {
                                object: oExampleButton,
                            },
                            {
                                object: oExampleButton,
                            },
                        ],
                    });
                },
            },
        },
    ];

    gridInstance = GuiCreateFromJSON(_json, GUI_ROOT);
}