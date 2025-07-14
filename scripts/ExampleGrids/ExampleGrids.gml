// Feather disable all

function ExampleGrids()
{
    with(oMain)
    {
        var _json = {
            object: oBentoBox,
            layout: {
                padding: 40,
                gutter: 35,
                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                list: [BENTO_AXIS_Y, 0.5, 0],
            },
            children: [
                {
                    object: oBentoBox,
                    layout: {
                        list: [BENTO_AXIS_X, 0.5, 0.5],
                        gutter: 35,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                    },
                    children: [
                        {
                            object: oBentoText,
                            vars: {
                                text: "Grids Example",
                                font: fntDebug,
                            },
                        },
                        {
                            object: oExampleButton,
                            vars: {
                                text: "Back",
                                clickFunc: ExampleHomePage,
                            },
                        },
                    ],
                },
                {
                    object: oBentoBox,
                    layout: {
                        grid: [2, 2],
                        resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                        gutter: 10,
                    },
                    children: [
                        {
                            object: oExampleButton,
                            vars: {
                                text: "Button",
                            },
                        },
                        {
                            object: oExampleButton,
                            vars: {
                                text: "Button",
                            },
                        },
                        {
                            object: oExampleButton,
                            vars: {
                                text: "Button",
                            },
                        },
                        {
                            object: oExampleButton,
                            vars: {
                                text: "Button",
                            },
                        },
                    ],
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
    }
}