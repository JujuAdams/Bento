// Feather disable all

function ExampleHomePage()
{
    with(oMain)
    {
        var _json = {
            object: oBentoBox,
            layout: {
                padding: 40,
                gutter: 35,
                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                list: [BENTO_AXIS_Y, fa_center, fa_top],
            },
            children: [
                {
                    object: oBentoSprite,
                    vars: {
                        sprite_index: sBentoLogo,
                    },
                },
                {
                    object: oBentoText,
                    vars: {
                        text: $"Bento {BENTO_VERSION}",
                        font: fntDebug,
                    },
                },
                {
                    object: oBentoText,
                    vars: {
                        text: $"Welcome to Bento! This is version {BENTO_VERSION} released on {BENTO_DATE}. This is an ALPHA build and as such any code and behaviour is liable to change. Please do NOT use this version of Bento as the basis for production code. This ALPHA build is intended for experimentation and fulfilling personal curiosity, and I suppose game jams too.",
                        font: fntDebug,
                    },
                },
                {
                    object: oBentoBox,
                    layout: {
                        gutter: 35,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                        list: [BENTO_AXIS_X, fa_center, fa_middle],
                    },
                    children: [
                        {
                            object: oExampleButton,
                            vars: {
                                text: "Open repo",
                                clickFunc: function()
                                {
                                    url_open("https://www.github.com/jujuadams/Bento/");
                                }
                            },
                        },
                        {
                            object: oExampleButton,
                            vars: {
                                text: "Juju's website",
                                clickFunc: function()
                                {
                                    url_open("https://www.jujuadams.com/");
                                }
                            },
                        },
                    ],
                },
                {
                    object: oExampleScrollboxWithBar,
                    layout: {
                        list: [BENTO_AXIS_Y, fa_center, fa_top],
                        padding: 20,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                        gutter: 15,
                    },
                    children: [
                        {
                            object: oExampleButton,
                            vars: {
                                text: $"Example: Buttons",
                                clickFunc: ExampleButtons,
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