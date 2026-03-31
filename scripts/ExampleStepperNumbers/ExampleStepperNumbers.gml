// Feather disable all

global.stepperExample = 10;

function ExampleStepperNumbers()
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
                                text: "Stepper",
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
                        text: "These particular steppers deal with numeric values. They're implemented as buttons with some extra behaviour when using keyboard or gamepad input. Clicking on the left and right side of the button will decrease or increase the value.",
                    },
                },
                {
                    object: oBentoExText,
                    vars: {
                        text: "When using a keyboard or gamepad, the stepper will need to be focused first. Then, by pressing left or right using the arrow keys or thumbstick / d-pad, the value for the stepper can be changed. The need to focus the stepper first before changed the value can be disabled if you'd like.",
                    },
                },
                {
                    select: true,
                    object: oBentoExStepperNumbers,
                    vars: {
                        text: "Stepper",
                        valueMin: 1,
                        valueMax: 20,
                        reference: BentoRef(global, "stepperExample"),
                    },
                },
                {
                    object: oBentoExTextDynamic,
                    vars: {
                        text: function()
                        {
                            return $"global.stepperExample = {global.stepperExample}";
                        }
                    },
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
    }
}