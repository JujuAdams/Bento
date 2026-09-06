// Feather disable all

function ExampleChangeInputMode()
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
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Change Input Mode" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePageJSON });
            }
            
            BentoCreate(oBentoExTextDynamic, {
                font: fntBentoExCandyBeans,
                text: function()
                {
                    if (BentoUsingMouse())
                    {
                        return $"Currently using mouse input";
                    }
                    else if (BentoUsingKeyboard())
                    {
                        return $"Currently using keyboard input";
                    }
                    else if (BentoUsingGamepad())
                    {
                        return $"Currently using gamepad input";
                    }
                    else if (BentoUsingTouch())
                    {
                        return $"Currently using touch input";
                    }
                    else
                    {
                        return $"Current using input mode {BentoGetMode()}";
                    }
                }
            });
            
            BentoCreate(oBentoExButton, {
                text: "Mouse",
                inoperative: (not BENTO_ON_DESKTOP),
                func: function()
                {
                    BentoSetMode(BENTO_MODE_MOUSE);
                },
            });
            
            BentoCreate(oBentoExButton, {
                text: "Keyboard",
                inoperative: (not BENTO_ON_DESKTOP),
                func: function()
                {
                    BentoSetMode(BENTO_MODE_KEYBOARD);
                },
            });
            
            BentoCreate(oBentoExButton, {
                text: "Keyboard",
                inoperative: (not BENTO_ON_DESKTOP),
                func: function()
                {
                    BentoSetMode(BENTO_MODE_KEYBOARD);
                },
            });
            
            BentoCreate(oBentoExButton, {
                text: "Gamepad",
                func: function()
                {
                    BentoSetMode(BENTO_MODE_GAMEPAD);
                },
            });
            
            BentoCreate(oBentoExButton, {
                text: "Touch",
                inoperative: not (BENTO_ON_DESKTOP || BENTO_ON_MOBILE),
                func: function()
                {
                    BentoSetMode(BENTO_MODE_TOUCH);
                },
            });
            
            BentoCreate(oBentoExText, {
                text: (not BENTO_ON_DESKTOP)? "" : "You can also use the 1 / 2 / 3 / 4 keys to set input mode.",
                font: fntBentoExCandyBeans,
            });
        }
    }
}

function ExampleChangeInputModeJSON()
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
                                text: "Change Input Mode",
                                font: fntBentoExCandyBeansBig,
                            },
                        },
                        {
                            object: oBentoExBackButton,
                            hover: true,
                            vars: {
                                func: ExampleHomePageJSON,
                            },
                        },
                    ],
                },
                {
                    object: oBentoExTextDynamic,
                    vars: {
                        text: function()
                        {
                            if (BentoUsingMouse())
                            {
                                return $"Currently using mouse input";
                            }
                            else if (BentoUsingKeyboard())
                            {
                                return $"Currently using keyboard input";
                            }
                            else if (BentoUsingGamepad())
                            {
                                return $"Currently using gamepad input";
                            }
                            else if (BentoUsingTouch())
                            {
                                return $"Currently using touch input";
                            }
                            else
                            {
                                return $"Current using input mode {BentoGetMode()}";
                            }
                        },
                        font: fntBentoExCandyBeans,
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: "Mouse",
                        inoperative: (not BENTO_ON_DESKTOP),
                        func: function()
                        {
                            BentoSetMode(BENTO_MODE_MOUSE);
                        },
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: "Keyboard",
                        inoperative: (not BENTO_ON_DESKTOP),
                        func: function()
                        {
                            BentoSetMode(BENTO_MODE_KEYBOARD);
                        },
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: "Gamepad",
                        func: function()
                        {
                            BentoSetMode(BENTO_MODE_GAMEPAD);
                        },
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: "Touch",
                        inoperative: not (BENTO_ON_DESKTOP || BENTO_ON_MOBILE),
                        func: function()
                        {
                            BentoSetMode(BENTO_MODE_TOUCH);
                        },
                    },
                },
                {
                    object: oBentoExText,
                    vars: {
                        text: (not BENTO_ON_DESKTOP)? "" : "You can also use the 1 / 2 / 3 / 4 keys to set input mode.",
                        font: fntBentoExCandyBeans,
                    },
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
    }
}