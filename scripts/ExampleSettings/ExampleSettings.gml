// Feather disable all

global.settings = {
    checkbox1: true,
    checkbox2: false,
    slider: 5,
    radiobutton: 1,
};

function ExampleSettings()
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
                                text: "Settings Menu Example",
                                font: fntBentoExCandyBeans,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Back",
                                func: ExampleHomePage,
                            },
                        },
                    ],
                },
                {
                    object: oBentoExSpacer,
                    layout: {
                        list: [BENTO_AXIS_Y, 0.5, 0.5],
                        gutter: 15,
                    },
                    children: [
                        {
                            select: true,
                            object: oBentoExCheckbox,
                            vars: {
                                text: "Checkbox 1",
                                reference: BentoRef(global.settings, "checkbox1"),
                            },
                        },
                        {
                            construct: [BentoExConstrCheckbox, BentoRef(global.settings, "checkbox2"), "Checkbox 2"],
                        },
                        {
                            object: oBentoExSlider,
                            vars: {
                                reference: BentoRef(global.settings, "slider"),
                            },
                            layout: {
                                size: [200, undefined],
                            },
                        },
                        {
                            object: oBentoExRadioButton,
                            vars: {
                                text: "Radio Button 1",
                                reference: BentoRef(global.settings, "radiobutton"),
                                value: 1,
                            },
                        },
                        {
                            object: oBentoExRadioButton,
                            vars: {
                                text: "Radio Button 2",
                                reference: BentoRef(global.settings, "radiobutton"),
                                value: 2,
                            },
                        },
                        {
                            object: oBentoExRadioButton,
                            vars: {
                                text: "Radio Button 3",
                                reference: BentoRef(global.settings, "radiobutton"),
                                value: 3,
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