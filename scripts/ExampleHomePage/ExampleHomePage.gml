// Feather disable all

function ExampleHomePage()
{
    with(oMain)
    {
        BentoDestroy(mainElement);
        
        mainElement = BentoCreateBlank(BentoLayerGetRoot());
        with(mainElement)
        {
            BentoLayoutSetPadding(40);
            BentoLayoutSetGutter(30, 30);
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
            BentoLayoutList(BentoGetLandscape()? BENTO_AXIS_X : BENTO_AXIS_Y, 0.5, 0);
            
            with(BentoCreateBlank())
            {
                BentoLayoutSetGutter(30, 30);
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
                
                BentoCreate(oBentoExSpriteWithShadow, { sprite_index: sBentoExLogoBig });
                BentoCreate(oBentoExText, { text: $"Bento {BENTO_VERSION}", font: fntBentoExCandyBeansBig, });
                BentoCreate(oBentoExText, { text: $"Welcome to Bento! This is version {BENTO_VERSION} released on {BENTO_DATE}. This is an alpha build and as such any code and behaviour is liable to change. Please do NOT use this version of Bento as the basis for serious commercial production code. This alpha build is intended for experimentation and fulfilling personal curiosity, and I suppose game jams too.", });
                
                with(BentoCreateBlank())
                {
                    BentoLayoutSetGutter(35, 35);
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                    BentoLayoutList(BENTO_AXIS_X, 0.5, 0.5);
                    
                    BentoCreate(oBentoExButton, { text: "Credits & Licenses", func: ExampleCreditsAndLicenses });
                    BentoCreate(oBentoExButton, { text: "Change Input Mode",  func: ExampleChangeInputMode    });
                }
            }
            
            with(BentoCreate(oBentoExListboxWithBar))
            {
                BentoApplySkin("thick frame");
                BentoLayoutSetGutter(15, 15);
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
                
                BentoCreate(oBentoExButton, { text: "Scribble",                func: ExampleScribble             });
                BentoCreate(oBentoExButton, { text: "Buttons",                 func: ExampleButtons              });
                BentoCreate(oBentoExButton, { text: "Buttons With Long Click", func: ExampleButtonsWithLongClick });
                BentoCreate(oBentoExButton, { text: "Manual Positions",        func: ExampleManualPositions      });
                BentoCreate(oBentoExButton, { text: "Lists",                   func: ExampleLists                });
                BentoCreate(oBentoExButton, { text: "Reorder Lists",           func: ExampleReorderLists         });
                BentoCreate(oBentoExButton, { text: "Modal",                   func: ExampleModal                });
                BentoCreate(oBentoExButton, { text: "Carry (Drag & Drop)",     func: ExampleCarry                });
                BentoCreate(oBentoExButton, { text: "Grids",                   func: ExampleGrids                });
                BentoCreate(oBentoExButton, { text: "Navigation Wrapping",     func: ExampleNavigationWrap       });
                BentoCreate(oBentoExButton, { text: "Checkbox",                func: ExampleCheckbox             });
                BentoCreate(oBentoExButton, { text: "Radio Button",            func: ExampleRadioButton          });
                BentoCreate(oBentoExButton, { text: "Stepper (strings)",       func: ExampleStepperStrings       });
                BentoCreate(oBentoExButton, { text: "Stepper (numbers)",       func: ExampleStepperNumbers       });
                BentoCreate(oBentoExButton, { text: "Slider",                  func: ExampleSlider               });
                BentoCreate(oBentoExButton, { text: "Main Menu",               func: ExampleMainMenu             });
                BentoCreate(oBentoExButton, { text: "Settings Menu",           func: ExampleSettingsMenu         });
                BentoCreate(oBentoExButton, { text: "Context Menu",            func: ExampleContextMenu          });
                BentoCreate(oBentoExButton, { text: "Text Scroll",             func: ExampleTextScroll           });
                BentoCreate(oBentoExButton, { text: "Scrolling List",          func: ExampleScrollingList        });
                BentoCreate(oBentoExButton, { text: "Scrolling List With Bar", func: ExampleScrollingListWithBar });
                BentoCreate(oBentoExButton, { text: "Listbox",                 func: ExampleListbox              });
                BentoCreate(oBentoExButton, { text: "Listbox With Bar",        func: ExampleListboxWithBar       });
                BentoCreate(oBentoExButton, { text: "Textbox",                 func: ExampleTextbox              });
                BentoCreate(oBentoExButton, { text: "Absolute Position",       func: ExamplePosition             });
            }
        }
    }
}

function ExampleHomePageJSON()
{
    with(oMain)
    {
        var _blurb = {
            object: oBentoExParent,
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
                    object: oBentoExParent,
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
                                func: ExampleCreditsAndLicenses,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Change Input Mode",
                                func: ExampleChangeInputMode,
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
                        text: $"Scribble",
                        func: ExampleScribble,
                    },
                },
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
                        func: ExampleModal,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Carry (Drag & Drop)",
                        func: ExampleCarry,
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
                        text: $"Navigation Wrapping",
                        func: ExampleNavigationWrap,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: $"Checkbox",
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
        };
        
        var _listParams = BentoGetLandscape()? [BENTO_AXIS_X, 0.5, 0] : [BENTO_AXIS_Y, 0.5, 0];
        
        var _json = {
            object: oBentoExParent,
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