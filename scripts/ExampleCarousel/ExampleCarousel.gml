// Feather disable all

global.carouselExample = "red";

function ExampleCarousel()
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
                                text: "Carousel Example",
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
                    object: oBentoExCarousel,
                    vars: {
                        text: "Colour Selection",
                        optionArray: ["red", "yellow", "green", "blue", "purple"],
                        reference: BentoRef(global, "carouselExample"),
                    },
                },
                {
                    object: oBentoText,
                    vars: {
                        text: function()
                        {
                            return $"global.carouselExample = {global.carouselExample}";
                        }
                    },
                },
                {
                    object: oBentoExCarousel,
                    vars: {
                        text: "Colour Selection\n(but backwards)",
                        optionArray: ["red", "purple", "blue", "green", "yellow"],
                        reference: BentoRef(global, "carouselExample"),
                    },
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
    }
}