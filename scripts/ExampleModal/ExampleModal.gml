// Feather disable all

function ExampleModal()
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
                                text: "Modals",
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
                    object: oBentoExText,
                    vars: {
                        text: "A \"modal\" is a user interface element that prevents interaction with button behind it. Modals are used in situations where the player has to resolve an issue or make a decision before the game can proceed.",
                        font: fntBentoExCandyBeans,
                    },
                },
                {
                    object: oBentoExText,
                    vars: {
                        text: "An example of a modal would be a dialog box that confirms that the player would like to delete their save game. Another example would be asking the player to resolve a disconnected gamepad.",
                        font: fntBentoExCandyBeans,
                    },
                },
                {
                    object: oBentoExText,
                    vars: {
                        text: "Modals are implemented in Bento by using layers. Only the top layer may receive user input. Layers underneath the top layer are called \"backgrounded\" and will not receive user input.",
                        font: fntBentoExCandyBeans,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: "Open modal",
                        func: function()
                        {
                            BentoLayerCreate("modal 1");
                            BentoCreateFromJSON({
                                object: oBentoExSpacer,
                                layout: {
                                    padding: 40,
                                    gutter: 35,
                                    resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                                    list: [BENTO_AXIS_Y, 0.5, 0],
                                },
                                children: [
                                    {
                                        object: oBentoExModalFrame,
                                        layout: {
                                            padding: 40,
                                            gutter: 35,
                                            resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                                            list: [BENTO_AXIS_Y, 0.5, 0.5],
                                        },
                                        children: [
                                            {
                                                object: oBentoExText,
                                                vars: {
                                                    text: "Wow! It's a modal!",
                                                },
                                            },
                                            {
                                                object: oBentoExSpacer,
                                                layout: {
                                                    padding: 40,
                                                    gutter: 35,
                                                    resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                                                    list: [BENTO_AXIS_X, 0.5, 0.5],
                                                },
                                                children: [
                                                    {
                                                        object: oBentoExButton,
                                                        vars: {
                                                            text: "Yep",
                                                            func: function()
                                                            {
                                                                BentoLayerDestroy("modal 1");
                                                            },
                                                        },
                                                    },
                                                    {
                                                        object: oBentoExButton,
                                                        vars: {
                                                            text: "Open another",
                                                            func: function()
                                                            {
                                                                BentoLayerCreate("modal 2");
                                                                BentoCreateFromJSON({
                                                                    object: oBentoExSpacer,
                                                                    layout: {
                                                                        padding: 40,
                                                                        gutter: 35,
                                                                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                                                                        list: [BENTO_AXIS_Y, 0.5, 0.5],
                                                                    },
                                                                    children: [
                                                                        {
                                                                            object: oBentoExModalFrame,
                                                                            layout: {
                                                                                padding: 40,
                                                                                gutter: 35,
                                                                                resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                                                                                list: [BENTO_AXIS_Y, 0.5, 0.5],
                                                                            },
                                                                            children: [
                                                                                {
                                                                                    object: oBentoExText,
                                                                                    vars: {
                                                                                        text: "Another modal!",
                                                                                    },
                                                                                },
                                                                                {
                                                                                    object: oBentoExButton,
                                                                                    vars: {
                                                                                        text: "Close please",
                                                                                        func: function()
                                                                                        {
                                                                                            BentoLayerDestroy("modal 2");
                                                                                        },
                                                                                    },
                                                                                },
                                                                            ],
                                                                        },
                                                                    ],
                                                                },
                                                                undefined, BentoLayerGetRoot("modal 2"));
                                                            }
                                                        },
                                                    },
                                                ],
                                            }
                                        ],
                                    },
                                ],
                            },
                            undefined, BentoLayerGetRoot("modal 1"));
                        },
                    },
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
    }
}