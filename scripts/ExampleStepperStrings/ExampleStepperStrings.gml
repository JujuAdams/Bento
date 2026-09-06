// Feather disable all

global.stepperStringsExample = "red";

function ExampleStepperStrings()
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
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Stepper" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePageJSON });
            }
            
            BentoCreate(oBentoExText, {
                text: "These particular steppers cycle through strings. They're implemented as buttons with some extra behaviour when using keyboard or gamepad input. Clicking on the left and right side of the button will cycle through options.",
            });
            
            BentoCreate(oBentoExText, {
                text: "When using a keyboard or gamepad, the stepper will need to be focused first. By pressing left or right using the arrow keys or thumbstick / d-pad the option can then be cycled through. The need to focus the stepper first before changed the value can be disabled if you'd like.",
            });
            
            BentoCreate(oBentoExStepperStrings, {
                text: "Colour Selection",
                stringArray: ["red", "yellow", "green", "blue", "purple"],
                reference: BentoRef(global, "stepperStringsExample"),
            });
            BentoHover(BENTO_PREV_ELEMENT);
            
            BentoCreate(oBentoExTextDynamic, {
                text: function()
                {
                    return $"global.stepperStringsExample = {global.stepperStringsExample}";
                },
            });
            
            BentoCreate(oBentoExStepperStrings, {
                text: "Backwards Selection",
                stringArray: ["red", "purple", "blue", "green", "yellow"],
                reference: BentoRef(global, "stepperStringsExample"),
            });
        }
    }
}

function ExampleStepperStringsJSON()
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
                                text: "Stepper (strings)",
                                font: fntBentoExCandyBeansBig,
                            },
                        },
                        {
                            object: oBentoExBackButton,
                            vars: {
                                func: ExampleHomePageJSON,
                            },
                        },
                    ],
                },
                {
                    object: oBentoExText,
                    vars: {
                        text: "These particular steppers cycle through strings. They're implemented as buttons with some extra behaviour when using keyboard or gamepad input. Clicking on the left and right side of the button will cycle through options.",
                    },
                },
                {
                    object: oBentoExText,
                    vars: {
                        text: "When using a keyboard or gamepad, the stepper will need to be focused first. By pressing left or right using the arrow keys or thumbstick / d-pad the option can then be cycled through. The need to focus the stepper first before changed the value can be disabled if you'd like.",
                    },
                },
                {
                    hover: true,
                    object: oBentoExStepperStrings,
                    vars: {
                        text: "Colour Selection",
                        stringArray: ["red", "yellow", "green", "blue", "purple"],
                        reference: BentoRef(global, "stepperStringsExample"),
                    },
                },
                {
                    object: oBentoExTextDynamic,
                    vars: {
                        text: function()
                        {
                            return $"global.stepperStringsExample = {global.stepperStringsExample}";
                        }
                    },
                },
                {
                    hover: true,
                    object: oBentoExStepperStrings,
                    vars: {
                        text: "Backwards Selection",
                        stringArray: ["red", "purple", "blue", "green", "yellow"],
                        reference: BentoRef(global, "stepperStringsExample"),
                    },
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
    }
}