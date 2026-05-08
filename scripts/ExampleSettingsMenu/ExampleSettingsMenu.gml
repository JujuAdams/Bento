// Feather disable all

global.settingsStruct = {
    flimflams: false,
    wibbles: true,
    bathJam: "strawberry",
    flatness: 7,
    sailorScout: "Moon",
    favoriteEvenNumber: 2,
};

function ExampleSettingsMenu()
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
                                text: "Settings Menu",
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
                        text: "This is an example of a settings menu.",
                        font: fntBentoExCandyBeans,
                    },
                },
                {
                    object: oBentoExSpacer,
                    layout: {
                        list: [BENTO_AXIS_X, 0, 0],
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                    },
                    children: [
                        {
                            object: oBentoExText,
                            hover: true,
                            vars: {
                                text: "Flimflams",
                                font: fntBentoExCandyBeansBig,
                            },
                        },
                        {
                            object: oBentoExSpacer,
                            layout: {
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                            },
                        },
                        {
                            object: oBentoExCheckbox,
                            vars: {
                                reference: BentoRef(global.settingsStruct, "flimflams"),
                            },
                        },
                    ],
                },
                {
                    object: oBentoExSpacer,
                    layout: {
                        list: [BENTO_AXIS_X, 0, 0],
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                    },
                    children: [
                        {
                            object: oBentoExText,
                            vars: {
                                text: "Wibbles",
                                font: fntBentoExCandyBeansBig,
                            },
                        },
                        {
                            object: oBentoExSpacer,
                            layout: {
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                            },
                        },
                        {
                            object: oBentoExCheckbox,
                            vars: {
                                reference: BentoRef(global.settingsStruct, "wibbles"),
                            },
                        },
                    ],
                },
                {
                    object: oBentoExFrame,
                    layout: {
                        list: [BENTO_AXIS_Y, 0, 0],
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                        padding: 20,
                        gutter: 20,
                    },
                    children: [
                        {
                            object: oBentoExText,
                            vars: {
                                text: "What type of jam do you bathe in?",
                            },
                        },
                        {
                            object: oBentoExSpacer,
                            layout: {
                                list: [BENTO_AXIS_X, 0, 0],
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                            },
                            children: [
                                {
                                    object: oBentoExText,
                                    vars: {
                                        text: "Strawberry",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                },
                                {
                                    object: oBentoExSpacer,
                                    layout: {
                                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                                    },
                                },
                                {
                                    object: oBentoExRadioButton,
                                    vars: {
                                        value: "strawberry",
                                        reference: BentoRef(global.settingsStruct, "bathJam"),
                                    },
                                },
                            ],
                        },
                        {
                            object: oBentoExSpacer,
                            layout: {
                                list: [BENTO_AXIS_X, 0, 0],
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                            },
                            children: [
                                {
                                    object: oBentoExText,
                                    vars: {
                                        text: "Raspberry",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                },
                                {
                                    object: oBentoExSpacer,
                                    layout: {
                                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                                    },
                                },
                                {
                                    object: oBentoExRadioButton,
                                    vars: {
                                        value: "raspberry",
                                        reference: BentoRef(global.settingsStruct, "bathJam"),
                                    },
                                },
                            ],
                        },
                        {
                            object: oBentoExSpacer,
                            layout: {
                                list: [BENTO_AXIS_X, 0, 0],
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                            },
                            children: [
                                {
                                    object: oBentoExText,
                                    vars: {
                                        text: "Marmalade",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                },
                                {
                                    object: oBentoExSpacer,
                                    layout: {
                                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                                    },
                                },
                                {
                                    object: oBentoExRadioButton,
                                    vars: {
                                        value: "marmalade",
                                        reference: BentoRef(global.settingsStruct, "bathJam"),
                                    },
                                },
                            ],
                        },
                    ],
                },
                {
                    object: oBentoExSpacer,
                    layout: {
                        list: [BENTO_AXIS_X, 0, 0.5],
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                        gutter: 20,
                    },
                    children: [
                        {
                            object: oBentoExText,
                            vars: {
                                text: "Earth Flatness",
                                font: fntBentoExCandyBeansBig,
                            },
                        },
                        {
                            object: oBentoExSlider,
                            layout: {
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_NORMAL],
                            },
                            vars: {
                                reference: BentoRef(global.settingsStruct, "flatness"),
                            },
                        },
                    ],
                },
                {
                    object: oBentoExSpacer,
                    layout: {
                        list: [BENTO_AXIS_X, 0, 0.5],
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                        gutter: 20,
                    },
                    children: [
                        {
                            hover: true,
                            object: oBentoExStepperStrings,
                            vars: {
                                text: "Sailor Scout",
                                stringArray: ["Mercury", "Venus", "Earth", "Moon", "Mars", "Jupiter", "Saturn", "Uranus", "Pluto"],
                                reference: BentoRef(global.settingsStruct, "sailorScout"),
                            },
                        },
                        {
                            object: oBentoExSpacer,
                            layout: {
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                            },
                        },
                        {
                            object: oBentoExStepperNumbers,
                            vars: {
                                text: "Favourite Even Number",
                                valueMin: 2,
                                valueStep: 2,
                                reference: BentoRef(global.settingsStruct, "favoriteEvenNumber"),
                            },
                        },
                    ],
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: "Reset",
                        font: fntBentoExCandyBeansBig,
                        func: function()
                        {
                            BentoLayerCreate("reset settings modal");
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
                                                    font: fntBentoExCandyBeansBig,
                                                    hAlign: fa_center,
                                                    text: "Are you sure you want to reset your settings? This cannot be undone!",
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
                                                            text: "No thanks",
                                                            hover: true,
                                                            func: function()
                                                            {
                                                                BentoLayerDestroy();
                                                            },
                                                        },
                                                    },
                                                    {
                                                        object: oBentoExButton,
                                                        vars: {
                                                            text: "Yes, please reset",
                                                            func: function()
                                                            {
                                                                global.settingsStruct.flimflams          = false;
                                                                global.settingsStruct.wibbles            = true;
                                                                global.settingsStruct.bathJam            = "strawberry";
                                                                global.settingsStruct.flatness           = 7;
                                                                global.settingsStruct.sailorScout        = "Moon";
                                                                global.settingsStruct.favoriteEvenNumber = 2;
                                                                BentoLayerDestroy();
                                                            },
                                                        },
                                                    },
                                                ],
                                            }
                                        ],
                                    },
                                ],
                            },
                            undefined, BentoLayerGetRoot("reset settings modal"));
                        },
                    },
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
    }
}