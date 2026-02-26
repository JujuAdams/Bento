// Feather disable all

global.sliderExample = 10;

function ExampleSlider()
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
                                text: "Slider Example",
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
                    select: true,
                    object: oBentoExSlider,
                    vars: {
                        text: "Slider",
                        valueMin: 1,
                        valueMax: 20,
                        reference: BentoRef(global, "sliderExample"),
                    },
                    layout: {
                        resize: [BENTO_RESIZE_INFLATE, undefined],
                    },
                },
                {
                    object: oBentoText,
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
        mainElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
    }
}