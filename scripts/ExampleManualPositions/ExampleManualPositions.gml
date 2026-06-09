// Feather disable all

function ExampleManualPositions()
{
    with(oMain)
    {
        BentoDestroy(mainElement);
        
        mainElement = BentoCreate(oBentoExSpacer, undefined, BentoLayerGetRoot());
        with(mainElement)
        {
            BentoLayoutSetPaddingExt(40, 40, 40, 40);
            BentoLayoutSetGutter(35, 35);
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
            BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
            
            with(BentoCreate(oBentoExSpacer))
            {
                BentoLayoutSetGutter(35, 35);
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_X, 0.5, 0);
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Manual Positions" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePageJSON });
            }
            
            BentoCreate(oBentoExText, { font: fntBentoExCandyBeans, text: "Bento has fancy tools to automatically lay out elements but often manual positioning is more convenient." });
            
            with(BentoCreate(oBentoExFrame))
            {
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                BentoLayoutSetPadding(20);
                
                BentoCreate(oBentoExButton, { text: "Hello" });
                
                with(BentoCreate(oBentoExButton, { text: "World" }))
                {
                    BentoSetOffset(100, 0);
                }
                
                with(BentoCreate(oBentoExButton, { text: "Bottom-right" }))
                {
                    BentoLayoutSetAnchor(1, 1);
                }
                
                with(BentoCreate(oBentoExButton, { text: "Centre-middle" }))
                {
                    BentoLayoutSetAnchor(0.5, 0.5);
                }
                
                with(BentoCreate(oBentoExButton, { text: "400, 330" }))
                {
                    BentoSetPosition(400, 330);
                }
                
                with(BentoCreate(oBentoExTextDynamic, { text: function()
                {
                    return $"{BentoCursorGetX()}, {BentoCursorGetY()}";
                }}))
                {
                    BentoLayoutSetAnchor(1, 0);
                }
            }
        }
    }
}

function ExampleManualPositionsJSON()
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
                                text: "Manual Positions",
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
                        text: "Bento has fancy tools to automatically lay out elements but often manual positioning is more convenient.",
                        font: fntBentoExCandyBeans,
                    },
                },
                {
                    object: oBentoExFrame,
                    layout: {
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                        padding: 20,
                    },
                    children: [
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Hello",
                            },
                        },
                        {
                            object: oBentoExButton,
                            offset: [100, 0],
                            vars: {
                                text: "World",
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Bottom-right",
                            },
                            layout: {
                                anchor: [1, 1],
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Centre-middle",
                            },
                            layout: {
                                anchor: [0.5, 0.5],
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "400, 330",
                            },
                            position: [400, 330],
                        },
                        {
                            object: oBentoExTextDynamic,
                            vars: {
                                text: function()
                                {
                                    return $"{BentoCursorGetX()}, {BentoCursorGetY()}";
                                },
                            },
                            layout: {
                                anchor: [1, 0],
                            },
                        },
                    ],
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
    }
}