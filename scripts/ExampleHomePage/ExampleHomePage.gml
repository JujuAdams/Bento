// Feather disable all

function ExampleHomePage()
{
    with(oMain)
    {
        var _json = {
            object: oBentoExSpacer,
            layout: {
                padding: 40,
                gutter: 30,
                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                list: [BENTO_AXIS_Y, 0.5, 0],
            },
            children: [
                {
                    object: oBentoExSpriteWithShadow,
                    vars: {
                        sprite_index: sBentoExLogoBig,
                    },
                },
                {
                    object: oBentoExText,
                    vars: {
                        text: $"Bento {BENTO_VERSION}",
                        font: fntBentoExCandyBeansBig,
                    },
                },
                {
                    object: oBentoExText,
                    vars: {
                        text: $"Welcome to Bento! This is version {BENTO_VERSION} released on {BENTO_DATE}. This is an alpha build and as such any code and behaviour is liable to change. Please do NOT use this version of Bento as the basis for serious commercial production code. This alpha build is intended for experimentation and fulfilling personal curiosity, and I suppose game jams too.",
                    },
                },
                {
                    object: oBentoExSpacer,
                    layout: {
                        gutter: 35,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                        list: [BENTO_AXIS_X, 0.5, 0.5],
                    },
                    children: [
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Credits & Licenses",
                                func: ExampleCreditsAndLicenses
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Change Input Mode",
                                func: ExampleChangeInputMode
                            },
                        },
                    ],
                },
                {
                    object: oBentoExListboxWithBar,
                    skin: "thick frame",
                    layout: {
                        list: [BENTO_AXIS_Y, 0.5, 0],
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                        gutter: 15,
                    },
                    children: [
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Buttons",
                                func: ExampleButtons,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Lists",
                                func: ExampleLists,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Grids",
                                func: ExampleGrids,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Checkbox Menu",
                                func: ExampleCheckbox,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Radio Button",
                                func: ExampleRadioButton,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Stepper (strings)",
                                func: ExampleStepperStrings,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Stepper (numbers)",
                                func: ExampleStepperNumbers,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Slider",
                                func: ExampleSlider,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Context Menu",
                                func: ExampleContextMenu,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Text Scroll",
                                func: ExampleTextScroll,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Scrolling List",
                                func: ExampleScrollingList,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Scrolling List With Bar",
                                func: ExampleScrollingListWithBar,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Listbox",
                                func: ExampleListbox,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Listbox With Bar",
                                func: ExampleListboxWithBar,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Textbox",
                                func: ExampleTextbox,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Absolute Position",
                                func: ExamplePosition,
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