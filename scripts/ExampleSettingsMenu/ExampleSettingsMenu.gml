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
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Settings Menu" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePage });
            }
            
            BentoCreate(oBentoExText, { text: "This is an example of a settings menu.", font: fntBentoExCandyBeans });
            
            with(BentoCreate(BentoGetLandscape()? oBentoExScrollingListWithBar : oBentoExParent))
            {
                if (BentoGetLandscape())
                {
                    BentoLayoutSetPaddingExt(20, 25, 20, 25);
                }
                
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
                BentoLayoutSetGutter(35, 35);
            
                with(BentoCreateBlank())
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                    BentoLayoutList(BENTO_AXIS_X, 0, 0);
                
                    BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Flimflams" });
                
                    with(BentoCreateBlank())
                    {
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                    }
                
                    BentoCreate(oBentoExCheckbox, { reference: BentoRef(global.settingsStruct, "flimflams") });
                    BentoHoverSoft(BENTO_PREV_ELEMENT);
                }
            
                with(BentoCreateBlank())
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                    BentoLayoutList(BENTO_AXIS_X, 0, 0);
                
                    BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Wibbles" });
                
                    with(BentoCreateBlank())
                    {
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                    }
                
                    BentoCreate(oBentoExCheckbox, { reference: BentoRef(global.settingsStruct, "wibbles") });
                }
            
                with(BentoCreate(oBentoExFrame))
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                    BentoLayoutList(BENTO_AXIS_Y, 0, 0);
                    BentoLayoutSetPadding(20);
                    BentoLayoutSetGutter(20, 20);
                
                    BentoCreate(oBentoExText, { font: fntBentoExCandyBeans, text: "What type of jam do you bathe in?" });
                
                    with(BentoCreateBlank())
                    {
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                        BentoLayoutList(BENTO_AXIS_X, 0, 0);
                    
                        BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Strawberry" });
                    
                        with(BentoCreateBlank())
                        {
                            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                        }
                    
                        BentoCreate(oBentoExRadioButton, { value: "strawberry", reference: BentoRef(global.settingsStruct, "bathJam") });
                    }
                
                    with(BentoCreateBlank())
                    {
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                        BentoLayoutList(BENTO_AXIS_X, 0, 0);
                    
                        BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Raspberry" });
                    
                        with(BentoCreateBlank())
                        {
                            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                        }
                    
                        BentoCreate(oBentoExRadioButton, { value: "raspberry", reference: BentoRef(global.settingsStruct, "bathJam") });
                    }
                
                    with(BentoCreateBlank())
                    {
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                        BentoLayoutList(BENTO_AXIS_X, 0, 0);
                    
                        BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Marmalade" });
                    
                        with(BentoCreateBlank())
                        {
                            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                        }
                    
                        BentoCreate(oBentoExRadioButton, { value: "marmalade", reference: BentoRef(global.settingsStruct, "bathJam") });
                    }
                }
            
                with(BentoCreateBlank())
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                    BentoLayoutList(BENTO_AXIS_X, 0, 0.5);
                    BentoLayoutSetGutter(20, 20);
                
                    BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Earth Flatness" });
                
                    with(BentoCreate(oBentoExSlider, { reference: BentoRef(global.settingsStruct, "flatness") }))
                    {
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_NORMAL);
                    }
                }
            
                with(BentoCreateBlank())
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                    BentoLayoutList(BENTO_AXIS_X, 0, 0.5);
                
                    BentoCreate(oBentoExStepperStrings, {
                        text: "Sailor Scout",
                        stringArray: ["Mercury", "Venus", "Earth", "Moon", "Mars", "Jupiter", "Saturn", "Uranus", "Pluto"],
                        reference: BentoRef(global.settingsStruct, "sailorScout"),
                    });
                
                    with(BentoCreateBlank())
                    {
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                    }
                
                    BentoCreate(oBentoExStepperNumbers, {
                        text: "Favourite Even Number",
                        valueMin: 2,
                        valueStep: 2,
                        reference: BentoRef(global.settingsStruct, "favoriteEvenNumber"),
                    });
                }
            
                BentoCreate(oBentoExButton, { text: "Reset", font: fntBentoExCandyBeansBig, func: function()
                {
                    BentoLayerCreate("reset settings modal");
                    with(BentoCreateBlank(BentoLayerGetRoot("reset settings modal")))
                    {
                        BentoLayoutSetPadding(40);
                        BentoLayoutSetGutter(35, 35);
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                        BentoLayoutList(BENTO_AXIS_Y, 0.5, 0.5);
                    
                        with(BentoCreate(oBentoExModalFrame))
                        {
                            BentoLayoutSetPadding(40);
                            BentoLayoutSetGutter(35, 35);
                            BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                            BentoLayoutList(BENTO_AXIS_Y, 0.5, 0.5);
                        
                            BentoCreate(oBentoExText, {
                                text: "Are you sure you want to reset your settings? This cannot be undone!",
                                hAlign: fa_center,
                                font: fntBentoExCandyBeansBig,
                            });
                        
                            with(BentoCreateBlank())
                            {
                                BentoLayoutSetPadding(40);
                                BentoLayoutSetGutter(35, 35);
                                BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                                BentoLayoutList(BENTO_AXIS_X, 0.5, 0.5);
                            
                                BentoCreate(oBentoExButton, { text: "No thanks", func: function()
                                {
                                    BentoLayerDestroy();
                                }});
                                BentoHover(BENTO_PREV_ELEMENT);
                            
                                BentoCreate(oBentoExButton, { text: "Yes, please reset", func: function()
                                {
                                    global.settingsStruct.flimflams          = false;
                                    global.settingsStruct.wibbles            = true;
                                    global.settingsStruct.bathJam            = "strawberry";
                                    global.settingsStruct.flatness           = 7;
                                    global.settingsStruct.sailorScout        = "Moon";
                                    global.settingsStruct.favoriteEvenNumber = 2;
                                    BentoLayerDestroy();
                                }});
                            }
                        }
                    }
                }});
            }
        }
    }
}

function ExampleSettingsMenuJSON()
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
                    object: oBentoExParent,
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
                            object: oBentoExParent,
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
                    object: oBentoExParent,
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
                            object: oBentoExParent,
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
                            object: oBentoExParent,
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
                                    object: oBentoExParent,
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
                            object: oBentoExParent,
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
                                    object: oBentoExParent,
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
                            object: oBentoExParent,
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
                                    object: oBentoExParent,
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
                    object: oBentoExParent,
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
                    object: oBentoExParent,
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
                            object: oBentoExParent,
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
                                object: oBentoExParent,
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
                                                object: oBentoExParent,
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