// Feather disable all

function ExampleChangeInputModeJSON()
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