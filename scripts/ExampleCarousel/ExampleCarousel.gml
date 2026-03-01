// Feather disable all

global.carouselExample = "red";

function ExampleCarousel()
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
                                text: "Carousel",
                                font: fntBentoExCandyBeansBig,
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
                    object: oBentoExTextDynamic,
                    vars: {
                        text: function()
                        {
                            return $"global.carouselExample = {global.carouselExample}";
                        }
                    },
                },
                {
                    construct: [BentoExConstrCarousel, BentoRef(global, "carouselExample"), ["red", "purple", "blue", "green", "yellow"], "Colour Selection\n(but backwards)"],
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
    }
}