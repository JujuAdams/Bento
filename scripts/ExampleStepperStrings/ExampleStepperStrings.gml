// Feather disable all

global.stepperStringsExample = "red";

function ExampleStepperStrings()
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
                                text: "Stepper (strings)",
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
                    construct: [BentoExConstrStepperStrings, BentoRef(global, "stepperStringsExample"), ["red", "purple", "blue", "green", "yellow"], "Colour Selection\n(but backwards)"],
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
    }
}