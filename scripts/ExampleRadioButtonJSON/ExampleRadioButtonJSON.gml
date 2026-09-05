// Feather disable all

global.settings = {
    checkbox1: true,
    checkbox2: false,
    slider: 5,
    radiobutton: 1,
};

function ExampleRadioButtonJSON()
{
    with(oMain)
    {
        var _json = {
            object: oBentoExParent,
            layout: {
                padding: 40,
                gutter: 35,
                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                list: [BENTO_AXIS_Y, 0.5, 0],
            },
            children: [
                {
                    object: oBentoExParent,
                    layout: {
                        list: [BENTO_AXIS_X, 0.5, 0.5],
                        gutter: 35,
                        resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                    },
                    children: [
                        {
                            object: oBentoExText,
                            vars: {
                                text: "Settings Menu Example",
                                font: fntBentoExCandyBeansBig,
                            },
                        },
                        {
                            object: oBentoExBackButton,
                            vars: {
                                func: ExampleHomePageJSON,
                            },
                        },
                    ],
                },
                {
                    object: oBentoExText,
                    vars: {
                        text: "Radio buttons allow the player to select between multiple mutually exclusive options. Radio buttons share the same variable to store state.",
                    },
                },
                {
                    object: oBentoExParent,
                    layout: {
                        list: [BENTO_AXIS_Y, 0.5, 0.5],
                        gutter: 15,
                    },
                    children: [
                        {
                            object: oBentoExRadioButton,
                            vars: {
                                text: "Radio Button 1",
                                reference: BentoRef(global.settings, "radiobutton"),
                                value: 1,
                            },
                            layout: {
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_NORMAL],
                            },
                        },
                        {
                            object: oBentoExRadioButton,
                            vars: {
                                text: "Radio Button 2",
                                reference: BentoRef(global.settings, "radiobutton"),
                                value: 2,
                            },
                            layout: {
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_NORMAL],
                            },
                        },
                        {
                            object: oBentoExRadioButton,
                            vars: {
                                text: "Radio Button 3",
                                reference: BentoRef(global.settings, "radiobutton"),
                                value: 3,
                            },
                            layout: {
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_NORMAL],
                            },
                        },
                    ],
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
    }
}