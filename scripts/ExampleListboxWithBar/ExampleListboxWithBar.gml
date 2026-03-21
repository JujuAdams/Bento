// Feather disable all

function ExampleListboxWithBar()
{
    with(oMain)
    {
        var _json = {
            object: oBentoExSpacer,
            layout: {
                padding: 40,
                gutter: 35,
                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                list: [BENTO_AXIS_Y, 0.5, 0],
            },
            children: [
                {
                    object: oBentoExSpacer,
                    layout: {
                        list: [BENTO_AXIS_X, 0.5, 0.5],
                        gutter: 35,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                    },
                    children: [
                        {
                            object: oBentoExText,
                            vars: {
                                text: "Listbox (& scrollbar)",
                                font: fntBentoExCandyBeansBig,
                            },
                        },
                        {
                            object: oBentoExBackButton,
                            vars: {
                                func: ExampleHomePage,
                            },
                        },
                    ],
                },
                {
                    object: oBentoExListboxWithBar,
                    layout: {
                        maxSize: [200, 295],
                        resize:  [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                        padding: 10,
                        gutter:  10,
                    },
                    children: function(_metadata) {
                        //Create identical copies of references to the same struct
                        //This is purely for demonstration purposes; real code would do this differently
                        return array_create_ext(_metadata.count, function(_index)
                        {
                            return {
                                object: oBentoExButton,
                                select: (_index == 0),
                                vars: {
                                    text: string(_index),
                                },
                                layout: {
                                    resize: [BENTO_RESIZE_INFLATE, undefined],
                                }
                            };
                        });
                    },
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, { count: 15 }, BentoGetRoot());
    }
}