// Feather disable all

function ExampleHomePageJSON()
{
    with(oMain)
    {
        var _blurb = {
            object: oBentoExSpacer,
            layout: {
                gutter: 30,
                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
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
                                func: ExampleCreditsAndLicensesJSON
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Change Input Mode",
                                func: ExampleChangeInputModeJSON
                            },
                        },
                    ],
                },
            ],
        };
        
        var _menu = 
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
                        text: $"Buttons With Long Click",
                        func: ExampleButtonsWithLongClick,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Manual Positions",
                        func: ExampleManualPositions,
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
                        text: $"Reorder Lists",
                        func: ExampleReorderLists,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Modal",
                        func: ExampleModalJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Carry (Drag & Drop)",
                        func: ExampleCarryJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Grids",
                        func: ExampleGridsJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Raycast Wrapping",
                        func: ExampleRaycastWrapJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Checkbox Menu",
                        func: ExampleCheckboxJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Radio Button",
                        func: ExampleRadioButtonJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Stepper (strings)",
                        func: ExampleStepperStringsJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Stepper (numbers)",
                        func: ExampleStepperNumbersJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Slider",
                        func: ExampleSliderJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Main Menu",
                        func: ExampleMainMenu,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Settings Menu",
                        func: ExampleSettingsMenu,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Context Menu",
                        func: ExampleContextMenuJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Text Scroll",
                        func: ExampleTextScrollJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Scrolling List",
                        func: ExampleScrollingListJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Scrolling List With Bar",
                        func: ExampleScrollingListWithBarJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Listbox",
                        func: ExampleListboxJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Listbox With Bar",
                        func: ExampleListboxWithBarJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Textbox",
                        func: ExampleTextboxJSON,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Absolute Position",
                        func: ExamplePositionJSON,
                    },
                },
            ],
        };
        
        var _listParams = BentoGetLandscape()? [BENTO_AXIS_X, 0.5, 0] : [BENTO_AXIS_Y, 0.5, 0];
        
        var _json = {
            object: oBentoExSpacer,
            layout: {
                padding: 40,
                gutter: 30,
                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                list: _listParams,
            },
            children: [
                _blurb,
                _menu,
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
    }
}