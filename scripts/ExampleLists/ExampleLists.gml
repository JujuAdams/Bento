// Feather disable all

function ExampleLists()
{
    with(oMain)
    {
        var _json = {
            object: oBentoBox,
            layout: {
                padding: 40,
                gutter: 35,
                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                list: [BENTO_AXIS_Y, fa_center, fa_top],
            },
            children: [
                {
                    object: oBentoBox,
                    layout: {
                        list: [BENTO_AXIS_X, fa_center, fa_middle],
                        gutter: 35,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                    },
                    children: [
                        {
                            object: oBentoText,
                            vars: {
                                text: "Lists Example",
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
                    object: oBentoText,
                    vars: {
                        text: "",
                        font: fntDebug,
                    },
                },
                {
                    object: oBentoBox,
                    layout: {
                        list: [BENTO_AXIS_Y, fa_center, fa_top],
                        resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                        gutter: 20,
                    },
                    children: [
                    
                    ],
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
    }
}