// Feather disable all

function ExampleHomePage()
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
                    object: oBentoExSprite,
                    vars: {
                        sprite_index: sBentoLogo,
                    },
                },
                {
                    object: oBentoExText,
                    vars: {
                        text: $"Bento {BENTO_VERSION}",
                        font: fntDebug,
                    },
                },
                {
                    object: oBentoExText,
                    vars: {
                        text: $"Welcome to Bento! This is version {BENTO_VERSION} released on {BENTO_DATE}. This is an alpha build and as such any code and behaviour is liable to change. Please do NOT use this version of Bento as the basis for production code. This alpha build is intended for experimentation and fulfilling personal curiosity, and I suppose game jams too.",
                        font: fntDebug,
                    },
                },
                {
                    object: oBentoExSpacer,
                    layout: {
                        gutter: 35,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                        list: [BENTO_AXIS_X, 0.5, 0.5],
                    },
                    children: [
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Open repo",
                                func: function()
                                {
                                    url_open("https://www.github.com/jujuadams/Bento/");
                                }
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Juju's website",
                                func: function()
                                {
                                    url_open("https://www.jujuadams.com/");
                                }
                            },
                        },
                    ],
                },
                {
                    object: oBentoExScrollboxWithBar,
                    layout: {
                        list: [BENTO_AXIS_Y, 0.5, 0],
                        padding: 20,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                        gutter: 15,
                    },
                    children: [
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Example: Buttons",
                                func: ExampleButtons,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Example: Lists",
                                func: ExampleLists,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Example: Grids",
                                func: ExampleGrids,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Example: Settings Menu",
                                func: ExampleSettings,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Example: Carousel",
                                func: ExampleCarousel,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Example: Scroller",
                                func: ExampleScroller,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Example: Slider",
                                func: ExampleSlider,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Example: Context Menu",
                                func: ExampleContextMenu,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Example: Scrolling List",
                                func: ExampleScrollingList,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Example: Scrolling List With Bar",
                                func: ExampleScrollingListWithBar,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Example: Scrollbox",
                                func: ExampleScrollbox,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Example: Scrollbox With Bar",
                                func: ExampleScrollboxWithBar,
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: $"Example: Textbox",
                                func: ExampleTextbox,
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