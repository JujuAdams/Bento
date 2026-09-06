// Feather disable all

global.settings = {
    checkbox1: true,
    checkbox2: false,
    slider: 5,
    radiobutton: 1,
};

function ExampleRadioButton()
{
    with(oMain)
    {
        BentoDestroy(mainElement);
        
        mainElement = BentoCreateBlank(BentoLayerGetRoot());
        with(mainElement)
        {
            BentoLayoutSetPadding(40);
            BentoLayoutSetGutter(35, 35);
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
            BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
            
            with(BentoCreateBlank())
            {
                BentoLayoutSetGutter(35, 35);
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_X, 0.5, 0);
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Radio Buttons" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePage });
            }
            
            BentoCreate(oBentoExText, {
                text: "Radio buttons allow the player to select between multiple mutually exclusive options. Radio buttons share the same variable to store state.",
            });
            
            with(BentoCreateBlank())
            {
                BentoLayoutSetGutter(15, 15);
                BentoLayoutList(BENTO_AXIS_Y, 0.5, 0.5);
                
                BentoCreate(oBentoExRadioButton, {
                    text: "Radio Button 1",
                    reference: BentoRef(global.settings, "radiobutton"),
                    value: 1,
                });
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, undefined, BENTO_PREV_ELEMENT);
                
                BentoCreate(oBentoExRadioButton, {
                    text: "Radio Button 2",
                    reference: BentoRef(global.settings, "radiobutton"),
                    value: 2,
                });
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, undefined, BENTO_PREV_ELEMENT);
                
                BentoCreate(oBentoExRadioButton, {
                    text: "Radio Button 3",
                    reference: BentoRef(global.settings, "radiobutton"),
                    value: 3,
                });
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, undefined, BENTO_PREV_ELEMENT);
            }
        }
    }
}

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
                                text: "Radio Buttons",
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