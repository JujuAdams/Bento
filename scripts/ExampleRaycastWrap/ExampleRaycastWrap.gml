// Feather disable all

function ExampleRaycastWrap()
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
                                text: "Raycast Wrapping",
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
                    object: oBentoExSpacer,
                    layout: {
                        list: [BENTO_AXIS_X, 0.5, 0.5],
                        gutter: 35,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                    },
                    children: [
                        {
                            object: oBentoExSpacer,
                            layout: {
                                list: [BENTO_AXIS_Y, 0.5, 0],
                                gutter: 35,
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                            },
                            children: [
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 1",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetRaycastWrap(true, true);
                                    },
                                },
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 2",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetRaycastWrap(true, true);
                                    },
                                },
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 3",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetRaycastWrap(true, true);
                                    },
                                },
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 4",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetRaycastWrap(true, true);
                                    },
                                },
                            ],
                        },
                        {
                            object: oBentoExListbox,
                            layout: {
                                list: [BENTO_AXIS_Y, 0.5, 0],
                                gutter: 35,
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                                maxSize: [infinity, 200],
                            },
                            onCreate: function()
                            {
                                BentoSetRaycastWrap(true, true);
                            },
                            children: [
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 1",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetRaycastWrap(true, true);
                                    },
                                },
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 2",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetRaycastWrap(true, true);
                                    },
                                },
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 3",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetRaycastWrap(true, true);
                                    },
                                },
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 4",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetRaycastWrap(true, true);
                                    },
                                },
                            ],
                        },
                    ],
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
    }
}