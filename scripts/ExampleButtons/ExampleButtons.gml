// Feather disable all

function ExampleButtons()
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
                                text: "Buttons Example",
                                font: fntDebug,
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
                    object: oBentoText,
                    vars: {
                        text: "This example demonstrates various button behaviours. A \"button\" in Bento is any element that can be clicked by pressing the primary input (left mouse click, spacebar, [A] button on a gamepad etc.). Any element can be marked as a button.",
                        font: fntDebug,
                    },
                },
                {
                    object: oBentoText,
                    vars: {
                        text: "Buttons can further be filtered based on the input mode. There are occasions where a button should only be clickable in pointer (mouse and touch) modes or directional (keyboard and gamepad) modes. Use the equivalent constant when setting the button behaviour and Bento will take care of it for you.",
                        font: fntDebug,
                    },
                },
                {
                    object: oBentoText,
                    vars: {
                        text: "When a button is clicked, `BentoPrimaryGetClick()` will return `true` for one step, including in the Draw event for the element. You should only use this function for determining if a button has been deliberately clicked by the player; any other function is liable to return false values.",
                        font: fntDebug,
                    },
                },
                {
                    object: oBentoBox,
                    layout: {
                        list: [BENTO_AXIS_Y, 0.5, 0],
                        resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                        gutter: 20,
                    },
                    children: [
                        {
                            select: true,
                            object: oBentoExButton,
                            vars: {
                                text: "Always a button",
                            },
                            onCreate: function()
                            {
                                BentoSetButton(BENTO_BUTTON_ALWAYS);
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Pointer-only button",
                            },
                            onCreate: function()
                            {
                                BentoSetButton(BENTO_BUTTON_POINTER);
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Directional-only button",
                            },
                            onCreate: function()
                            {
                                BentoSetButton(BENTO_BUTTON_DIRECTIONAL);
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Never a button",
                            },
                            onCreate: function()
                            {
                                BentoSetButton(BENTO_BUTTON_NEVER);
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