// Feather disable all

global.sliderExample = 10;

function ExampleSlider()
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
                                text: "Slider",
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
                        text: "Sliders are convenient for controlling a numeric value. Sliders can be clicked and dragging to change the value or the player can click on the bar itself to set a value instantaneously.",
                    },
                },
                {
                    object: oBentoExText,
                    vars: {
                        text: "When using a keyboard or gamepad, the slider must first be focused. The arrow keys or thumbstick / d-pad can then be used to move the slider's handle to change the value.",
                    },
                },
                {
                    hover: true,
                    object: oBentoExSlider,
                    vars: {
                        text: "Slider",
                        valueMin: 1,
                        valueMax: 20,
                        handleWidthMin: 100,
                        reference: BentoRef(global, "sliderExample"),
                    },
                    layout: {
                        resize: [BENTO_RESIZE_INFLATE, undefined],
                    },
                },
                {
                    object: oBentoExTextDynamic,
                    vars: {
                        text: function()
                        {
                            return $"global.sliderExample = {global.sliderExample}";
                        }
                    },
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
    }
}