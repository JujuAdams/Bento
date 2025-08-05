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
                                text: "Settings Menu Example",
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
                        list: [BENTO_AXIS_Y, 0.5, 0.5],
                        gutter: 15,
                    },
                    children: [
                        {
                            object: oExampleCheckbox,
                            vars: {
                                text: "Checkbox 1",
                                reference: BentoRefCreate(global.settings, "checkbox1"),
                            },
                        },
                        {
                            object: oExampleCheckbox,
                            vars: {
                                text: "Checkbox 2",
                                reference: BentoRefCreate(global.settings, "checkbox2"),
                            },
                        },
                        {
                            object: oExampleSlider,
                            vars: {
                                reference: BentoRefCreate(global.settings, "slider"),
                            },
                            layout: {
                                size: [200, undefined],
                            },
                        },
                        {
                            object: oExampleRadioButton,
                            vars: {
                                text: "Radio Button 1",
                                reference: BentoRefCreate(global.settings, "radiobutton"),
                                option: 1,
                            },
                        },
                        {
                            object: oExampleRadioButton,
                            vars: {
                                text: "Radio Button 2",
                                reference: BentoRefCreate(global.settings, "radiobutton"),
                                option: 2,
                            },
                        },
                        {
                            object: oExampleRadioButton,
                            vars: {
                                text: "Radio Button 3",
                                reference: BentoRefCreate(global.settings, "radiobutton"),
                                option: 3,
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