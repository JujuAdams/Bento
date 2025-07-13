// Feather disable all

function ExampleButtons()
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
                                text: "Buttons Example",
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
                        grid: [5, 5],
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                    },
                    children: function()
                    {
                        return array_create_ext(25, function(_index)
                        {
                            return {
                                object: oExampleButton,
                                vars: {
                                    text: $"Text {_index}",
                                },
                                layout: {
                                    anchor: [0.5, 0.5],
                                },
                            };
                        });
                    },
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
    }
}